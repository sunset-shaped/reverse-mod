extends Node2D


# Declare member variables here. Examples:
# var a = 2
var base:Node
var backgoal = preload("res://backgoal.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	base = get_node("/root/base")
	base.connect("scene_changed", self, "_on_scene_change")

func _on_scene_change():
	base.state = "pause"

	base.player.position = get_tree().get_nodes_in_group("goal")[0].position
	get_tree().get_nodes_in_group("goal")[0].queue_free()
	var newback = backgoal.instance()
	var newscene = get_tree().get_nodes_in_group("room")[0]
	#print(newscene)
	
	if newscene.has_node("respawn1"):
		newback.position = newscene.get_node("respawn1").position + Vector2(-100, 0)
		newscene.get_node("respawn1").position = base.player.position
	elif newscene.has_node("respawn"):
		newback.position = newscene.get_node("respawn").position + Vector2(-100, 0)
		newscene.get_node("respawn").position = base.player.position
	
	if base.level == 4:
		var dietile = get_tree().get_nodes_in_group("die")[0]
		dietile.set_cell(95, -4, -1)
		dietile.set_cell(94, -4, -1)
		dietile.set_cell(95, -3, -1)
		dietile.set_cell(94, -3, -1)
		dietile.set_cell(95, -2, -1)
		dietile.set_cell(94, -2, -1)
		dietile.set_cell(95, -1, -1)
		dietile.set_cell(94, -1, -1)
		dietile.set_cell(95, 0, -1)
		dietile.set_cell(94, 0, -1)
		
	if base.level == 5:
		newback.final = true

	newscene.call_deferred("add_child", newback)
	yield(get_tree().create_timer(0.1), "timeout")
	base.state = "play"
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
