Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSCOIeU>; Fri, 15 Mar 2002 03:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSCOIeN>; Fri, 15 Mar 2002 03:34:13 -0500
Received: from [211.238.181.68] ([211.238.181.68]:5136 "EHLO
	mail.digitaldreamstudios.net") by vger.kernel.org with ESMTP
	id <S284180AbSCOId7>; Fri, 15 Mar 2002 03:33:59 -0500
Message-ID: <3C91B206.6EA173B7@nownuri.net>
Date: Fri, 15 Mar 2002 17:34:14 +0900
From: SeongTae Yoo <alloying@nownuri.net>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: file listing problem in smbfs, kernel 2.4.18
Content-Type: multipart/mixed;
 boundary="------------07A482C94EEB2C6DD9646A2B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------07A482C94EEB2C6DD9646A2B
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit

I have mounted a share of w2k server(SP2). All file lists is not seen
in a specific sub directory.

The error log is follows as:

    smb_proc_readdir_long: name=, result=-2, rcls=1, err=123

My Linux System is :

    Debian GNU/Linux, woody
    kernel : 2.4.18
    smbmount  : 2.2.3a
    samba  : 2.2.3a

The smbmount and samba was installed with debian package, not kernel.

    smbfs-2.2.3a-1, samba-2.2.3a-1

kernel compile option concerned with smbfs :

    CONFIG_SMB_FS=m
    CONFIG_SMB_NLS=y
    CONFIG_NLS=y
    CONFIG_NLS_DEFAULT="iso-8859-1"

    or

    CONFIG_SMB_FS=m
    CONFIG_SMB_NLS_DEFAULT=y
    CONFIG_SMB_NLS_REMOTE="cp949"
    CONFIG_SMB_NLS=y
    CONFIG_NLS=y
    CONFIG_NLS_DEFAULT="euc-kr"
    CONFIG_NLS_CODEPAGE_949=m

I have tested this problem at a different kernel version,
2.4.17, 2.4.18-rc2, 2.4.2, 2.2.14, 2.2.17, 2.2.19, 2.2.20,
however it has not been solved.

If a file (for example, a.txt) is added, then all file is
listed occasionally.

I will attached the file containing the files lists of the dir.

I hope this report helps .......
--------------07A482C94EEB2C6DD9646A2B
Content-Type: text/plain; charset=EUC-KR;
 name="filelist.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filelist.txt"

ama_arm_co.tif.cc.tex
ami_glass_dirty_C.tif.pp.tex
ami_glass_dirty_O.tif.pp.tex
amiel_arm_op.tif.bb.tex
amiel_ball_co.tif.cc.tex
amiel_body_co.tif.cc.tex
amiel_body_df.tif.cc.tex
amiel_dress_alpa.tif.cc.tex
amiel_dress_bott_alpa.tif.cc.tex
amiel_dress_co.tif.pp.tex
amiel_dress_m.tif.cc.tex
amiel_dress_m1.tif.cc.tex
amiel_dress_m2.tif.cc.tex
amiel_dress_m3.tif.cc.tex
amiel_dress_m4.tif.cc.tex
amiel_dress_m5.tif.cc.tex
amiel_face_co.tif.cc.tex
amiel_face_df.tif.cc.tex
amiel_h_co.tif.cc.tex
amiel_h_op.tif.bb.tex
amiel_h_op1.tif.bb.tex
amiel_h_op2.tif.bb.tex
amiel_h_op3.tif.bb.tex
amiel_iris_co.tif.cc.tex
amiel_lip_bp.tif.bb.tex
amiel_lip_sp.tif.bb.tex
amiel_nail.tif.cc.tex
amiel_ring_alpa.tif.cc.tex
amiel_ring_bp.tif.cc.tex
amiel_sleeve_co.tif.pp.tex
amiel_sleeve_op.tif.pp.tex
cornea_bp.tif.pp.tex
jail_nail.tif.cc.tex
jal_Metal_base.tif.pp.tex
jal_armor_arm01_bp.tif.cc.tex
jal_armor_arm01_dif.tif.cc.tex
jal_armor_arm02_MK.tif.cc.tex
jal_armor_arm02_bp.tif.cc.tex
jal_armor_arm02_dif.tif.cc.tex
jal_armor_back_01_bp.tif.cc.tex
jal_armor_back_01_dif.tif.cc.tex
jal_armor_back_02_bp.tif.cc.tex
jal_armor_back_02_dif.tif.cc.tex
jal_armor_back_03_bp.tif.cc.tex
jal_armor_back_03_dif.tif.cc.tex
jal_armor_back_04_bp.tif.cc.tex
jal_armor_back_04_dif.tif.cc.tex
jal_armor_center_bp.tif.cc.tex
jal_armor_center_dif.tif.cc.tex
jal_armor_flank_MK.tif.cc.tex
jal_armor_flank_bp.tif.cc.tex
jal_armor_flank_dif.tif.cc.tex
jal_armor_front_MK.tif.cc.tex
jal_armor_front_bp.tif.cc.tex
jal_armor_front_dif.tif.cc.tex
jal_armor_leg01_L_MK.tif.cc.tex
jal_armor_leg01_R_MK.tif.cc.tex
jal_armor_leg01_bp.tif.cc.tex
jal_armor_leg01_dif.tif.cc.tex
jal_armor_leg02_MK.tif.cc.tex
jal_armor_leg02_bp.tif.cc.tex
jal_armor_leg02_dif.tif.cc.tex
jal_armor_neck_bp.tif.cc.tex
jal_armor_shoulder01_L.tif.cc.tex
jal_armor_shoulder01_L_bp.tif.cc.tex
jal_armor_shoulder01_L_dif.tif.cc.tex
jal_armor_shoulder02_bp.tif.cc.tex
jal_armor_shoulder02_dif.tif.cc.tex
jal_armor_shoulder_R_MK.tif.cc.tex
jal_armor_shoulder_R_bp.tif.cc.tex
jal_armor_shoulder_R_dif.tif.cc.tex
jal_armor_shoulder_bp.tif.cc.tex
jal_armor_shoulder_dif.tif.cc.tex
jal_armor_side_bp.tif.cc.tex
jal_armor_side_dif.tif.cc.tex
jal_asp01_MK.tif.cc.tex
jal_asp01_bp.tif.cc.tex
jal_asp01_dif.tif.cc.tex
jal_asp02_bp.tif.cc.tex
jal_asp02_dif.tif.cc.tex
jal_ball_bp.tif.cc.tex
jal_ball_col.tif.cc.tex
jal_ball_dif.tif.cc.tex
jal_ball_sp.tif.cc.tex
jal_boot_body_MK.tif.cc.tex
jal_boot_body_bp.tif.cc.tex
jal_boot_body_dif.tif.cc.tex
jal_chin01_bp.tif.cc.tex
jal_chin03_bp.tif.cc.tex
jal_chin_bp.tif.cc.tex
jal_coat_pattern.tif.pp.tex
jal_eye_refl.tif.cc.tex
jal_finger02_bp.tif.cc.tex
jal_finger02_dif.tif.cc.tex
jal_finger03_bp.tif.cc.tex
jal_finger03_dif.tif.cc.tex
jal_hair_1_mk.tif.bb.tex
jal_hair_base.tif.cc.tex
jal_hair_base_alpa.tif.bb.tex
jal_hand_cover01_bp.tif.cc.tex
jal_hand_cover01_dif.tif.cc.tex
jal_hand_cover02_bp.tif.cc.tex
jal_hand_cover02_dif.tif.cc.tex
jal_hand_down_1.tif.cc.tex
jal_hand_up_1.tif.cc.tex
jal_hand_up_bump.tif.cc.tex
jal_helmet_asp_hole_bp.tif.cc.tex
jal_helmet_asp_hole_dif.tif.cc.tex
jal_helmet_back01_bp.tif.cc.tex
jal_helmet_back01_dif.tif.cc.tex
jal_helmet_cover_C_MK.tif.cc.tex
jal_helmet_cover_C_bp.tif.cc.tex
jal_helmet_cover_C_dif.tif.cc.tex
jal_helmet_cover_MK.tif.cc.tex
jal_helmet_cover_bp.tif.cc.tex
jal_helmet_cover_dif.tif.cc.tex
jal_helmet_inner01_bp.tif.cc.tex
jal_helmet_inner01_dif.tif.cc.tex
jal_helmet_inner02_bp.tif.cc.tex
jal_helmet_inner02_dif.tif.cc.tex
jal_helmet_inner03_dif.tif.cc.tex
jal_helmet_inner_jaw_bp.tif.cc.tex
jal_helmet_inner_jaw_dif.tif.cc.tex
jal_helmet_jaw_bp.tif.cc.tex
jal_helmet_jaw_dif.tif.cc.tex
jal_helmet_side_bp.tif.cc.tex
jal_helmet_side_dif.tif.cc.tex
jal_helmet_top02_bp.tif.cc.tex
jal_helmet_top02_dif.tif.cc.tex
jal_hemet_inner04_bp.tif.cc.tex
jal_hemet_inner04_dif.tif.cc.tex
jal_iris_bp.tif.cc.tex
jal_iris_col.tif.cc.tex
jal_iris_dif.tif.cc.tex
jal_iris_sp.tif.cc.tex
jal_mk1.tif.cc.tex
jal_mk1_col.tif.cc.tex
jal_sup_down.tif.cc.tex
jal_sup_up.tif.cc.tex
jallack_h_alpa1.tif.cc.tex
jallack_h_alpa2.tif.cc.tex
jallack_h_alpa3.tif.cc.tex
jallack_h_bump.tif.cc.tex
jallack_h_bump_1.tif.cc.tex
jallack_h_col1.tif.cc.tex
jallack_h_sp.tif.cc.tex
jallak_bp_face_1222.tif.cc.tex
jallak_bp_fur_1221.tif.cc.tex
jallak_bp_line2_l_1211.tif.cc.tex
jallak_bp_line2_r_1211.tif.cc.tex
jallak_bp_line3_l_1211.tif.cc.tex
jallak_bp_line3_r_1211.tif.cc.tex
jallak_bp_line4_r.tif.cc.tex
jallak_bp_line_l_1211.tif.cc.tex
jallak_bp_line_r_1211.tif.cc.tex
jallak_face_1.tif.cc.tex
jallak_face_base.tif.cc.tex
jallak_face_top2.tif.cc.tex
kidkin_armor_flank_MK.tif.cc.tex
kidkin_mk1.tif.cc.tex
kidkin_mk1_col.tif.cc.tex
kiskin_Metal_base.tif.pp.tex
kiskin_armor_arm01_bp.tif.cc.tex
kiskin_armor_arm01_dif.tif.cc.tex
kiskin_armor_arm02_MK.tif.cc.tex
kiskin_armor_arm02_bp.tif.cc.tex
kiskin_armor_arm02_dif.tif.cc.tex
kiskin_armor_back_01_bp.tif.cc.tex
kiskin_armor_back_01_dif.tif.cc.tex
kiskin_armor_back_02_bp.tif.cc.tex
kiskin_armor_back_02_dif.tif.cc.tex
kiskin_armor_back_03_bp.tif.cc.tex
kiskin_armor_back_03_dif.tif.cc.tex
kiskin_armor_back_04_bp.tif.cc.tex
kiskin_armor_back_04_dif.tif.cc.tex
kiskin_armor_center_bp.tif.cc.tex
kiskin_armor_center_dif.tif.cc.tex
kiskin_armor_flank_bp.tif.cc.tex
kiskin_armor_flank_dif.tif.cc.tex
kiskin_armor_front_MK.tif.cc.tex
kiskin_armor_front_bp.tif.cc.tex
kiskin_armor_front_dif.tif.cc.tex
kiskin_armor_leg01_L_MK.tif.cc.tex
kiskin_armor_leg01_R_MK.tif.cc.tex
kiskin_armor_leg01_bp.tif.cc.tex
kiskin_armor_leg01_dif.tif.cc.tex
kiskin_armor_leg02_MK.tif.cc.tex
kiskin_armor_leg02_bp.tif.cc.tex
kiskin_armor_leg02_dif.tif.cc.tex
kiskin_armor_neck_bp.tif.cc.tex
kiskin_armor_shoulder01_L.tif.cc.tex
kiskin_armor_shoulder01_L_bp.tif.cc.tex
kiskin_armor_shoulder01_L_dif.tif.cc.tex
kiskin_armor_shoulder02_bp.tif.cc.tex
kiskin_armor_shoulder02_dif.tif.cc.tex
kiskin_armor_shoulder_R_MK.tif.cc.tex
kiskin_armor_shoulder_R_bp.tif.cc.tex
kiskin_armor_shoulder_R_dif.tif.cc.tex
kiskin_armor_shoulder_bp.tif.cc.tex
kiskin_armor_shoulder_dif.tif.cc.tex
kiskin_armor_side_bp.tif.cc.tex
kiskin_armor_side_dif.tif.cc.tex
kiskin_asp01_MK.tif.cc.tex
kiskin_asp01_bp.tif.cc.tex
kiskin_asp01_dif.tif.cc.tex
kiskin_asp02_bp.tif.cc.tex
kiskin_asp02_dif.tif.cc.tex
kiskin_boot_body_MK.tif.cc.tex
kiskin_boot_body_bp.tif.cc.tex
kiskin_boot_body_dif.tif.cc.tex
kiskin_chin01_bp.tif.cc.tex
kiskin_chin03_bp.tif.cc.tex
kiskin_chin_bp.tif.cc.tex
kiskin_coat_pattern.tif.pp.tex
kiskin_finger02_bp.tif.cc.tex
kiskin_finger02_dif.tif.cc.tex
kiskin_finger03_bp.tif.cc.tex
kiskin_finger03_dif.tif.cc.tex
kiskin_hand_cover01_bp.tif.cc.tex
kiskin_hand_cover01_dif.tif.cc.tex
kiskin_hand_cover02_bp.tif.cc.tex
kiskin_hand_cover02_dif.tif.cc.tex
kiskin_helmet_asp_hole_bp.tif.cc.tex
kiskin_helmet_asp_hole_dif.tif.cc.tex
kiskin_helmet_back01_bp.tif.cc.tex
kiskin_helmet_back01_dif.tif.cc.tex
kiskin_helmet_cover_C_MK.tif.cc.tex
kiskin_helmet_cover_C_bp.tif.cc.tex
kiskin_helmet_cover_C_dif.tif.cc.tex
kiskin_helmet_cover_MK.tif.cc.tex
kiskin_helmet_cover_bp.tif.cc.tex
kiskin_helmet_cover_dif.tif.cc.tex
kiskin_helmet_inner01_bp.tif.cc.tex
kiskin_helmet_inner01_dif.tif.cc.tex
kiskin_helmet_inner02_bp.tif.cc.tex
kiskin_helmet_inner02_dif.tif.cc.tex
kiskin_helmet_inner03_dif.tif.cc.tex
kiskin_helmet_inner_jaw_bp.tif.cc.tex
kiskin_helmet_inner_jaw_dif.tif.cc.tex
kiskin_helmet_jaw_bp.tif.cc.tex
kiskin_helmet_jaw_dif.tif.cc.tex
kiskin_helmet_side_bp.tif.cc.tex
kiskin_helmet_side_dif.tif.cc.tex
kiskin_helmet_top02_bp.tif.cc.tex
kiskin_helmet_top02_dif.tif.cc.tex
kiskin_hemet_inner04_bp.tif.cc.tex
kiskin_hemet_inner04_dif.tif.cc.tex
pi_bat_Metal_base.tif.pp.tex
pi_bat_armor_arm01_bp.tif.cc.tex
pi_bat_armor_arm01_dif.tif.cc.tex
pi_bat_armor_arm02_MK.tif.cc.tex
pi_bat_armor_arm02_bp.tif.cc.tex
pi_bat_armor_arm02_dif.tif.cc.tex
pi_bat_armor_back_01_bp.tif.cc.tex
pi_bat_armor_back_01_dif.tif.cc.tex
pi_bat_armor_back_02_bp.tif.cc.tex
pi_bat_armor_back_02_dif.tif.cc.tex
pi_bat_armor_back_03_bp.tif.cc.tex
pi_bat_armor_back_03_dif.tif.cc.tex
pi_bat_armor_back_04_bp.tif.cc.tex
pi_bat_armor_back_04_dif.tif.cc.tex
pi_bat_armor_center_bp.tif.cc.tex
pi_bat_armor_center_dif.tif.cc.tex
pi_bat_armor_flank_MK.tif.cc.tex
pi_bat_armor_flank_bp.tif.cc.tex
pi_bat_armor_flank_dif.tif.cc.tex
pi_bat_armor_front_MK.tif.cc.tex
pi_bat_armor_front_bp.tif.cc.tex
pi_bat_armor_front_dif.tif.cc.tex
pi_bat_armor_leg01_L_MK.tif.cc.tex
pi_bat_armor_leg01_R_MK.tif.cc.tex
pi_bat_armor_leg01_bp.tif.cc.tex
pi_bat_armor_leg01_dif.tif.cc.tex
pi_bat_armor_leg02_MK.tif.cc.tex
pi_bat_armor_leg02_bp.tif.cc.tex
pi_bat_armor_leg02_dif.tif.cc.tex
pi_bat_armor_neck_bp.tif.cc.tex
pi_bat_armor_shoulder01_L.tif.cc.tex
pi_bat_armor_shoulder01_L_bp.tif.cc.tex
pi_bat_armor_shoulder01_L_dif.tif.cc.tex
pi_bat_armor_shoulder02_bp.tif.cc.tex
pi_bat_armor_shoulder02_dif.tif.cc.tex
pi_bat_armor_shoulder_R_MK.tif.cc.tex
pi_bat_armor_shoulder_R_bp.tif.cc.tex
pi_bat_armor_shoulder_R_dif.tif.cc.tex
pi_bat_armor_shoulder_bp.tif.cc.tex
pi_bat_armor_shoulder_dif.tif.cc.tex
pi_bat_armor_side_bp.tif.cc.tex
pi_bat_armor_side_dif.tif.cc.tex
pi_bat_asp01_MK.tif.cc.tex
pi_bat_asp01_bp.tif.cc.tex
pi_bat_asp01_dif.tif.cc.tex
pi_bat_asp02_bp.tif.cc.tex
pi_bat_asp02_dif.tif.cc.tex
pi_bat_boot_body_MK.tif.cc.tex
pi_bat_boot_body_bp.tif.cc.tex
pi_bat_boot_body_dif.tif.cc.tex
pi_bat_chin01_bp.tif.cc.tex
pi_bat_chin03_bp.tif.cc.tex
pi_bat_chin_bp.tif.cc.tex
pi_bat_coat_pattern.tif.pp.tex
pi_bat_finger02_bp.tif.cc.tex
pi_bat_finger02_dif.tif.cc.tex
pi_bat_finger03_bp.tif.cc.tex
pi_bat_finger03_dif.tif.cc.tex
pi_bat_hand_cover01_bp.tif.cc.tex
pi_bat_hand_cover01_dif.tif.cc.tex
pi_bat_hand_cover02_bp.tif.cc.tex
pi_bat_hand_cover02_dif.tif.cc.tex
pi_bat_helmet_asp_hole_bp.tif.cc.tex
pi_bat_helmet_asp_hole_dif.tif.cc.tex
pi_bat_helmet_back01_bp.tif.cc.tex
pi_bat_helmet_back01_dif.tif.cc.tex
pi_bat_helmet_cover_C_MK.tif.cc.tex
pi_bat_helmet_cover_C_bp.tif.cc.tex
pi_bat_helmet_cover_C_dif.tif.cc.tex
pi_bat_helmet_cover_MK.tif.cc.tex
pi_bat_helmet_cover_bp.tif.cc.tex
pi_bat_helmet_cover_dif.tif.cc.tex
pi_bat_helmet_inner01_bp.tif.cc.tex
pi_bat_helmet_inner01_dif.tif.cc.tex
pi_bat_helmet_inner02_bp.tif.cc.tex
pi_bat_helmet_inner02_dif.tif.cc.tex
pi_bat_helmet_inner03_dif.tif.cc.tex
pi_bat_helmet_inner_jaw_bp.tif.cc.tex
pi_bat_helmet_inner_jaw_dif.tif.cc.tex
pi_bat_helmet_jaw_bp.tif.cc.tex
pi_bat_helmet_jaw_dif.tif.cc.tex
pi_bat_helmet_side_bp.tif.cc.tex
pi_bat_helmet_side_dif.tif.cc.tex
pi_bat_helmet_top02_bp.tif.cc.tex
pi_bat_helmet_top02_dif.tif.cc.tex
pi_bat_hemet_inner04_bp.tif.cc.tex
pi_bat_hemet_inner04_dif.tif.cc.tex
pi_bat_mk1.tif.cc.tex
pi_bat_mk1_col.tif.cc.tex
pi_eyebrow_bp.tif.bb.tex
pi_face_bp.tif.cc.tex
pi_face_co.tif.cc.tex
pi_face_df.tif.cc.tex
pi_lip_bp.tif.bb.tex
pi_lip_sp.tif.bb.tex
pir_ball_co.tif.cc.tex
pir_iris_co.tif.cc.tex
showroom.TIF.cc.tex
showroom.tif.bb.tex
st_rifle2_body1.tif.bb.tex
st_rifle2_body1.tif.pp.tex
st_rifle2_body2_o.tif.bb.tex
st_rifle2_body3_o.tif.bb.tex
st_rifle2_center1_o.tif.bb.tex
st_rifle2_center2_o.tif.bb.tex
st_rifle2_center3_1_o.tif.bb.tex
st_rifle2_center3_o.tif.bb.tex
st_rifle2_center4_o.tif.bb.tex
st_rifle2_center5_o.tif.bb.tex
st_rifle2_center6_o.tif.bb.tex
st_rifle2_hand1_o.tif.bb.tex
st_rifle2_hand2_o.tif.bb.tex
st_rifle2_hand3_o.tif.bb.tex
st_rifle2_hand4_o.tif.bb.tex
st_rifle2_main1_b.tif.bb.tex
st_rifle2_main_body1_o.tif.bb.tex
st_rifle2_scratch2.tif.bb.tex
st_rifle2_scratch2_1.tif.bb.tex
tem0203_brown_land.tif.pp.tex
tem0203_cave.tif.pp.tex
tem0203_cave01.tif.pp.tex
tem0203_cave_B.tif.pp.tex
tem0203_cliff.tif.pp.tex
tem0203_cliff1K_C.tif.pp.tex
tem0203_cliff4K_B.tif.pp.tex
tem0203_cliff4K_C.tif.pp.tex
tem0203_ddangB.TIF.pp.tex
tem0203_ddangB4K.tif.pp.tex
tem0203_ddangC.TIF.pp.tex
tem0203_poza_B.tif.pp.tex
tem0203_reflection.tif.bb.tex
tem0203_reflection.tif.pp.tex
tem0203_smallstone.tif.pp.tex
tem0203_smallstone_B.tif.pp.tex
tem0203_sp_stone01_B.tif.pp.tex
tem0203_sp_stone01_C.tif.pp.tex
tem0203_sp_stone01_O.tif.pp.tex
tem0203_sp_stone03_B.tif.pp.tex
tem0203_sp_stone03_Ba.tif.pp.tex
tem0203_sp_stone03_C.tif.pp.tex
tem0203_sp_stone03_O.tif.pp.tex
tem0203_stone.tif.pp.tex
tem0203_stone_B.tif.pp.tex

--------------07A482C94EEB2C6DD9646A2B--

