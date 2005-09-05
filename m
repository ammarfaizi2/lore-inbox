Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVIEV30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVIEV30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVIEV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:17 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:3977 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932592AbVIEV3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:10 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 13/24] V4L: Normalize whitespace and comments in tuner
 lists
Message-ID: <431cb7f7.Cra9WoPFtV/YC3lM%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.vJXezTg2CpppKkwodWxeYaA+rxCTlVraiI9EcOxUCuaeVKTt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.vJXezTg2CpppKkwodWxeYaA+rxCTlVraiI9EcOxUCuaeVKTt
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.vJXezTg2CpppKkwodWxeYaA+rxCTlVraiI9EcOxUCuaeVKTt
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-13-patch.diff"

- normalize whitespace and comments in tuner lists

Signed-off-by: Philip Rowlands <phr@doc.ic.ac.uk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tuner-simple.c |   43 ++---
 linux/include/media/tuner.h              |  178 +++++++++++------------
 2 files changed, 109 insertions(+), 112 deletions(-)

diff -u /tmp/dst.32745 linux/include/media/tuner.h
--- /tmp/dst.32745	2005-09-05 11:42:56.000000000 -0300
+++ linux/include/media/tuner.h	2005-09-05 11:42:56.000000000 -0300
@@ -26,90 +26,90 @@
 
 #define ADDR_UNSET (255)
 
-#define TUNER_TEMIC_PAL     0        /* 4002 FH5 (3X 7756, 9483) */
-#define TUNER_PHILIPS_PAL_I 1
-#define TUNER_PHILIPS_NTSC  2
-#define TUNER_PHILIPS_SECAM 3		/* you must actively select B/G, L, L` */
-
-#define TUNER_ABSENT        4
-#define TUNER_PHILIPS_PAL   5
-#define TUNER_TEMIC_NTSC    6        /* 4032 FY5 (3X 7004, 9498, 9789)  */
-#define TUNER_TEMIC_PAL_I   7        /* 4062 FY5 (3X 8501, 9957)        */
-
-#define TUNER_TEMIC_4036FY5_NTSC 8   /* 4036 FY5 (3X 1223, 1981, 7686)  */
-#define TUNER_ALPS_TSBH1_NTSC 	 9
-#define TUNER_ALPS_TSBE1_PAL 	10
-#define TUNER_ALPS_TSBB5_PAL_I 	11
-
-#define TUNER_ALPS_TSBE5_PAL 	12
-#define TUNER_ALPS_TSBC5_PAL 	13
-#define TUNER_TEMIC_4006FH5_PAL	14   /* 4006 FH5 (3X 9500, 9501, 7291)     */
-#define TUNER_ALPS_TSHC6_NTSC 	15
-
-#define TUNER_TEMIC_PAL_DK	16   /* 4016 FY5 (3X 1392, 1393)     */
-#define TUNER_PHILIPS_NTSC_M	17
-#define TUNER_TEMIC_4066FY5_PAL_I       18  /* 4066 FY5 (3X 7032, 7035) */
-#define TUNER_TEMIC_4006FN5_MULTI_PAL   19  /* B/G, I and D/K autodetected (3X 7595, 7606, 7657)*/
-
-#define TUNER_TEMIC_4009FR5_PAL         20  /* incl. FM radio (3X 7607, 7488, 7711)*/
-#define TUNER_TEMIC_4039FR5_NTSC        21  /* incl. FM radio (3X 7246, 7578, 7732)*/
-#define TUNER_TEMIC_4046FM5             22  /* you must actively select B/G, D/K, I, L, L` !  (3X 7804, 7806, 8103, 8104)*/
+#define TUNER_TEMIC_PAL			0        /* 4002 FH5 (3X 7756, 9483) */
+#define TUNER_PHILIPS_PAL_I		1
+#define TUNER_PHILIPS_NTSC		2
+#define TUNER_PHILIPS_SECAM		3	/* you must actively select B/G, L, L` */
+
+#define TUNER_ABSENT			4
+#define TUNER_PHILIPS_PAL		5
+#define TUNER_TEMIC_NTSC		6	/* 4032 FY5 (3X 7004, 9498, 9789)  */
+#define TUNER_TEMIC_PAL_I		7	/* 4062 FY5 (3X 8501, 9957) */
+
+#define TUNER_TEMIC_4036FY5_NTSC	8	/* 4036 FY5 (3X 1223, 1981, 7686) */
+#define TUNER_ALPS_TSBH1_NTSC		9
+#define TUNER_ALPS_TSBE1_PAL		10
+#define TUNER_ALPS_TSBB5_PAL_I		11
+
+#define TUNER_ALPS_TSBE5_PAL		12
+#define TUNER_ALPS_TSBC5_PAL		13
+#define TUNER_TEMIC_4006FH5_PAL		14	/* 4006 FH5 (3X 9500, 9501, 7291) */
+#define TUNER_ALPS_TSHC6_NTSC		15
+
+#define TUNER_TEMIC_PAL_DK		16	/* 4016 FY5 (3X 1392, 1393) */
+#define TUNER_PHILIPS_NTSC_M		17
+#define TUNER_TEMIC_4066FY5_PAL_I	18	/* 4066 FY5 (3X 7032, 7035) */
+#define TUNER_TEMIC_4006FN5_MULTI_PAL	19	/* B/G, I and D/K autodetected (3X 7595, 7606, 7657) */
+
+#define TUNER_TEMIC_4009FR5_PAL		20	/* incl. FM radio (3X 7607, 7488, 7711) */
+#define TUNER_TEMIC_4039FR5_NTSC	21	/* incl. FM radio (3X 7246, 7578, 7732) */
+#define TUNER_TEMIC_4046FM5		22	/* you must actively select B/G, D/K, I, L, L` !  (3X 7804, 7806, 8103, 8104) */
 #define TUNER_PHILIPS_PAL_DK		23
 
-#define TUNER_PHILIPS_FQ1216ME		24  /* you must actively select B/G/D/K, I, L, L` */
-#define TUNER_LG_PAL_I_FM	25
-#define TUNER_LG_PAL_I		26
-#define TUNER_LG_NTSC_FM	27
-
-#define TUNER_LG_PAL_FM		28
-#define TUNER_LG_PAL		29
-#define TUNER_TEMIC_4009FN5_MULTI_PAL_FM	30  /* B/G, I and D/K autodetected (3X 8155, 8160, 8163)*/
-#define TUNER_SHARP_2U5JF5540_NTSC  31
-
-#define TUNER_Samsung_PAL_TCPM9091PD27 32
-#define TUNER_MT2032 33
-#define TUNER_TEMIC_4106FH5 	34	/* 4106 FH5 (3X 7808, 7865)*/
-#define TUNER_TEMIC_4012FY5	35	/* 4012 FY5 (3X 0971, 1099)*/
-
-#define TUNER_TEMIC_4136FY5	36	/* 4136 FY5 (3X 7708, 7746)*/
-#define TUNER_LG_PAL_NEW_TAPC   37
-#define TUNER_PHILIPS_FM1216ME_MK3  38
-#define TUNER_LG_NTSC_NEW_TAPC   39
-
-#define TUNER_HITACHI_NTSC       40
-#define TUNER_PHILIPS_PAL_MK     41
-#define TUNER_PHILIPS_ATSC       42
-#define TUNER_PHILIPS_FM1236_MK3 43
+#define TUNER_PHILIPS_FQ1216ME		24	/* you must actively select B/G/D/K, I, L, L` */
+#define TUNER_LG_PAL_I_FM		25
+#define TUNER_LG_PAL_I			26
+#define TUNER_LG_NTSC_FM		27
+
+#define TUNER_LG_PAL_FM			28
+#define TUNER_LG_PAL			29
+#define TUNER_TEMIC_4009FN5_MULTI_PAL_FM 30	/* B/G, I and D/K autodetected (3X 8155, 8160, 8163) */
+#define TUNER_SHARP_2U5JF5540_NTSC	31
+
+#define TUNER_Samsung_PAL_TCPM9091PD27	32
+#define TUNER_MT2032			33
+#define TUNER_TEMIC_4106FH5		34	/* 4106 FH5 (3X 7808, 7865) */
+#define TUNER_TEMIC_4012FY5		35	/* 4012 FY5 (3X 0971, 1099) */
+
+#define TUNER_TEMIC_4136FY5		36	/* 4136 FY5 (3X 7708, 7746) */
+#define TUNER_LG_PAL_NEW_TAPC		37
+#define TUNER_PHILIPS_FM1216ME_MK3	38
+#define TUNER_LG_NTSC_NEW_TAPC		39
+
+#define TUNER_HITACHI_NTSC		40
+#define TUNER_PHILIPS_PAL_MK		41
+#define TUNER_PHILIPS_ATSC		42
+#define TUNER_PHILIPS_FM1236_MK3	43
 
-#define TUNER_PHILIPS_4IN1       44	/* ATI TV Wonder Pro - Conexant */
+#define TUNER_PHILIPS_4IN1		44	/* ATI TV Wonder Pro - Conexant */
 /* Microtune mergeged with Temic 12/31/1999 partially financed by Alps - these may be similar to Temic */
-#define TUNER_MICROTUNE_4049FM5  45
-#define TUNER_LG_NTSC_TAPE       47
-
-#define TUNER_TNF_8831BGFF       48
-#define TUNER_MICROTUNE_4042FI5  49	/* DViCO FusionHDTV 3 Gold-Q - 4042 FI5 (3X 8147) */
-#define TUNER_TCL_2002N          50
-#define TUNER_PHILIPS_FM1256_IH3   51
-
-#define TUNER_THOMSON_DTT7610    52
-#define TUNER_PHILIPS_FQ1286     53
-#define TUNER_PHILIPS_TDA8290    54
-#define TUNER_LG_PAL_TAPE        55    /* Hauppauge PVR-150 PAL */
-
-#define TUNER_PHILIPS_FQ1216AME_MK4 56 /* Hauppauge PVR-150 PAL */
-#define TUNER_PHILIPS_FQ1236A_MK4   57   /* Hauppauge PVR-500MCE NTSC */
-
-#define TUNER_YMEC_TVF_8531MF 58
-#define TUNER_YMEC_TVF_5533MF 59	/* Pixelview Pro Ultra NTSC */
-#define TUNER_THOMSON_DTT7611 60	/* DViCO FusionHDTV 3 Gold-T */
-#define TUNER_TENA_9533_DI    61
-
-#define TUNER_TEA5767         62	/* Only FM Radio Tuner */
-#define TUNER_PHILIPS_FMD1216ME_MK3 63
-#define TUNER_LG_TDVS_H062F   64	/* DViCO FusionHDTV 5 */
-#define TUNER_YMEC_TVF66T5_B_DFF 65	/* Acorp Y878F */
-
-#define TUNER_LG_NTSC_TALN_MINI 66
+#define TUNER_MICROTUNE_4049FM5 	45
+#define TUNER_MICROTUNE_4042_FI5	46
+#define TUNER_LG_NTSC_TAPE		47
+
+#define TUNER_TNF_8831BGFF		48
+#define TUNER_MICROTUNE_4042FI5		49	/* DViCO FusionHDTV 3 Gold-Q - 4042 FI5 (3X 8147) */
+#define TUNER_TCL_2002N			50
+#define TUNER_PHILIPS_FM1256_IH3	51
+
+#define TUNER_THOMSON_DTT7610		52
+#define TUNER_PHILIPS_FQ1286		53
+#define TUNER_PHILIPS_TDA8290		54
+#define TUNER_LG_PAL_TAPE		55	/* Hauppauge PVR-150 PAL */
+
+#define TUNER_PHILIPS_FQ1216AME_MK4	56	/* Hauppauge PVR-150 PAL */
+#define TUNER_PHILIPS_FQ1236A_MK4	57	/* Hauppauge PVR-500MCE NTSC */
+#define TUNER_YMEC_TVF_8531MF		58
+#define TUNER_YMEC_TVF_5533MF		59	/* Pixelview Pro Ultra NTSC */
+
+#define TUNER_THOMSON_DTT7611		60	/* DViCO FusionHDTV 3 Gold-T */
+#define TUNER_TENA_9533_DI		61
+#define TUNER_TEA5767			62	/* Only FM Radio Tuner */
+#define TUNER_PHILIPS_FMD1216ME_MK3	63
+
+#define TUNER_LG_TDVS_H062F		64	/* DViCO FusionHDTV 5 */
+#define TUNER_YMEC_TVF66T5_B_DFF	65	/* Acorp Y878F */
+#define TUNER_LG_NTSC_TALN_MINI		66
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
@@ -117,7 +117,7 @@
 #define NTSC    3
 #define SECAM   4
 #define ATSC    5
-#define RADIO	6
+#define RADIO   6
 
 #define NoTuner 0
 #define Philips 1
@@ -163,21 +163,21 @@
 };
 
 struct tuner_setup {
-	unsigned short		addr;
-	unsigned int		type;
-	unsigned int		mode_mask;
+	unsigned short	addr;
+	unsigned int	type;
+	unsigned int	mode_mask;
 };
 
 struct tuner {
 	/* device */
 	struct i2c_client i2c;
 
-	unsigned int type;            /* chip type */
+	unsigned int type;	/* chip type */
 
-	unsigned int          mode;
-	unsigned int          mode_mask; /* Combination of allowable modes */
+	unsigned int mode;
+	unsigned int mode_mask;	/* Combination of allowable modes */
 
-	unsigned int freq;            /* keep track of the current settings */
+	unsigned int freq;	/* keep track of the current settings */
 	unsigned int audmode;
 	v4l2_std_id  std;
 
@@ -221,7 +221,7 @@
 
 #endif /* __KERNEL__ */
 
-#endif
+#endif /* _TUNER_H */
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -u /tmp/dst.32745 linux/drivers/media/video/tuner-simple.c
--- /tmp/dst.32745	2005-09-05 11:42:56.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-09-05 11:42:56.000000000 -0300
@@ -101,6 +101,7 @@
  *	"no float in kernel" rule.
  */
 static struct tunertype tuners[] = {
+	/* 0-9 */
         { "Temic PAL (4002 FH5)", TEMIC, PAL,
 	  16*140.25,16*463.25,0x02,0x04,0x01,0x8e,623},
 	{ "Philips PAL_I (FI1246 and compatibles)", Philips, PAL_I,
@@ -109,7 +110,6 @@
 	  16*157.25,16*451.25,0xA0,0x90,0x30,0x8e,732},
 	{ "Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)", Philips, SECAM,
 	  16*168.25,16*447.25,0xA7,0x97,0x37,0x8e,623},
-
 	{ "NoTuner", NoTuner, NOTUNER,
 	  0,0,0x00,0x00,0x00,0x00,0x00},
 	{ "Philips PAL_BG (FI1216 and compatibles)", Philips, PAL,
@@ -118,34 +118,34 @@
 	  16*157.25,16*463.25,0x02,0x04,0x01,0x8e,732},
 	{ "Temic PAL_I (4062 FY5)", TEMIC, PAL_I,
 	  16*170.00,16*450.00,0x02,0x04,0x01,0x8e,623},
-
  	{ "Temic NTSC (4036 FY5)", TEMIC, NTSC,
 	  16*157.25,16*463.25,0xa0,0x90,0x30,0x8e,732},
         { "Alps HSBH1", TEMIC, NTSC,
 	  16*137.25,16*385.25,0x01,0x02,0x08,0x8e,732},
-        { "Alps TSBE1",TEMIC,PAL,
+
+	/* 10-19 */
+        { "Alps TSBE1", TEMIC, PAL,
 	  16*137.25,16*385.25,0x01,0x02,0x08,0x8e,732},
         { "Alps TSBB5", Alps, PAL_I, /* tested (UK UHF) with Modulartech MM205 */
 	  16*133.25,16*351.25,0x01,0x02,0x08,0x8e,632},
-
         { "Alps TSBE5", Alps, PAL, /* untested - data sheet guess. Only IF differs. */
 	  16*133.25,16*351.25,0x01,0x02,0x08,0x8e,622},
         { "Alps TSBC5", Alps, PAL, /* untested - data sheet guess. Only IF differs. */
 	  16*133.25,16*351.25,0x01,0x02,0x08,0x8e,608},
 	{ "Temic PAL_BG (4006FH5)", TEMIC, PAL,
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
-  	{ "Alps TSCH6",Alps,NTSC,
+  	{ "Alps TSCH6", Alps, NTSC,
   	  16*137.25,16*385.25,0x14,0x12,0x11,0x8e,732},
-
-  	{ "Temic PAL_DK (4016 FY5)",TEMIC,PAL,
+  	{ "Temic PAL_DK (4016 FY5)", TEMIC, PAL,
   	  16*168.25,16*456.25,0xa0,0x90,0x30,0x8e,623},
-  	{ "Philips NTSC_M (MK2)",Philips,NTSC,
+  	{ "Philips NTSC_M (MK2)", Philips, NTSC,
   	  16*160.00,16*454.00,0xa0,0x90,0x30,0x8e,732},
         { "Temic PAL_I (4066 FY5)", TEMIC, PAL_I,
           16*169.00, 16*454.00, 0xa0,0x90,0x30,0x8e,623},
         { "Temic PAL* auto (4006 FN5)", TEMIC, PAL,
           16*169.00, 16*454.00, 0xa0,0x90,0x30,0x8e,623},
 
+	/* 20-29 */
         { "Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5)", TEMIC, PAL,
           16*141.00, 16*464.00, 0xa0,0x90,0x30,0x8e,623},
         { "Temic NTSC (4039 FR5)", TEMIC, NTSC,
@@ -154,7 +154,6 @@
           16*169.00, 16*454.00, 0xa0,0x90,0x30,0x8e,623},
         { "Philips PAL_DK (FI1256 and compatibles)", Philips, PAL,
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
-
 	{ "Philips PAL/SECAM multi (FQ1216ME)", Philips, PAL,
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
 	{ "LG PAL_I+FM (TAPC-I001D)", LGINNOTEK, PAL_I,
@@ -163,25 +162,24 @@
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
 	{ "LG NTSC+FM (TPI8NSR01F)", LGINNOTEK, NTSC,
 	  16*210.00,16*497.00,0xa0,0x90,0x30,0x8e,732},
-
 	{ "LG PAL_BG+FM (TPI8PSB01D)", LGINNOTEK, PAL,
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
 	{ "LG PAL_BG (TPI8PSB11D)", LGINNOTEK, PAL,
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
+
+	/* 30-39 */
 	{ "Temic PAL* auto + FM (4009 FN5)", TEMIC, PAL,
 	  16*141.00, 16*464.00, 0xa0,0x90,0x30,0x8e,623},
 	{ "SHARP NTSC_JP (2U5JF5540)", SHARP, NTSC, /* 940=16*58.75 NTSC@Japan */
 	  16*137.25,16*317.25,0x01,0x02,0x08,0x8e,940 },
-
-	{ "Samsung PAL TCPM9091PD27", Samsung, PAL,  /* from sourceforge v3tv */
+	{ "Samsung PAL TCPM9091PD27", Samsung, PAL, /* from sourceforge v3tv */
           16*169,16*464,0xA0,0x90,0x30,0x8e,623},
-	{ "MT20xx universal", Microtune,PAL|NTSC,
+	{ "MT20xx universal", Microtune, PAL|NTSC,
 	  /* see mt20xx.c for details */ },
 	{ "Temic PAL_BG (4106 FH5)", TEMIC, PAL,
           16*141.00, 16*464.00, 0xa0,0x90,0x30,0x8e,623},
 	{ "Temic PAL_DK/SECAM_L (4012 FY5)", TEMIC, PAL,
           16*140.25, 16*463.25, 0x02,0x04,0x01,0x8e,623},
-
 	{ "Temic NTSC (4136 FY5)", TEMIC, NTSC,
           16*158.00, 16*453.00, 0xa0,0x90,0x30,0x8e,732},
         { "LG PAL (newer TAPC series)", LGINNOTEK, PAL,
@@ -191,42 +189,41 @@
 	{ "LG NTSC (newer TAPC series)", LGINNOTEK, NTSC,
           16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,732},
 
+	/* 40-49 */
 	{ "HITACHI V7-J180AT", HITACHI, NTSC,
 	  16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,940 },
 	{ "Philips PAL_MK (FI1216 MK)", Philips, PAL,
 	  16*140.25,16*463.25,0x01,0xc2,0xcf,0x8e,623},
-	{ "Philips 1236D ATSC/NTSC daul in",Philips,ATSC,
+	{ "Philips 1236D ATSC/NTSC daul in", Philips, ATSC,
 	  16*157.25,16*454.00,0xa0,0x90,0x30,0x8e,732},
         { "Philips NTSC MK3 (FM1236MK3 or FM1236/F)", Philips, NTSC,
           16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732},
-
         { "Philips 4 in 1 (ATI TV Wonder Pro/Conexant)", Philips, NTSC,
           16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732},
-	{ "Microtune 4049 FM5",Microtune,PAL,
+	{ "Microtune 4049 FM5", Microtune, PAL,
 	  16*141.00,16*464.00,0xa0,0x90,0x30,0x8e,623},
 	{ "Panasonic VP27s/ENGE4324D", Panasonic, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x08,0xce,940},
         { "LG NTSC (TAPE series)", LGINNOTEK, NTSC,
           16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
-
         { "Tenna TNF 8831 BGFF)", Philips, PAL,
           16*161.25,16*463.25,0xa0,0x90,0x30,0x8e,623},
 	{ "Microtune 4042 FI5 ATSC/NTSC dual in", Microtune, NTSC,
 	  16*162.00,16*457.00,0xa2,0x94,0x31,0x8e,732},
+
+	/* 50-59 */
         { "TCL 2002N", TCL, NTSC,
           16*172.00,16*448.00,0x01,0x02,0x08,0x8e,732},
 	{ "Philips PAL/SECAM_D (FM 1256 I-H3)", Philips, PAL,
 	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,623 },
-
 	{ "Thomson DDT 7610 (ATSC/NTSC)", THOMSON, ATSC,
 	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
 	{ "Philips FQ1286", Philips, NTSC,
-	  16*160.00,16*454.00,0x41,0x42,0x04,0x8e,940}, // UHF band untested
-	{ "tda8290+75", Philips,PAL|NTSC,
+	  16*160.00,16*454.00,0x41,0x42,0x04,0x8e,940}, /* UHF band untested */
+	{ "tda8290+75", Philips, PAL|NTSC,
 	  /* see tda8290.c for details */ },
 	{ "LG PAL (TAPE series)", LGINNOTEK, PAL,
           16*170.00, 16*450.00, 0x01,0x02,0x08,0xce,623},
-
 	{ "Philips PAL/SECAM multi (FQ1216AME MK4)", Philips, PAL,
 	  16*160.00,16*442.00,0x01,0x02,0x04,0xce,623 },
 	{ "Philips FQ1236A MK4", Philips, NTSC,
@@ -236,6 +233,7 @@
 	{ "Ymec TVision TVF-5533MF", Philips, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x04,0x8e,732},
 
+	/* 60-66 */
 	{ "Thomson DDT 7611 (ATSC/NTSC)", THOMSON, ATSC,
 	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
 	{ "Tena TNF9533-D/IF/TNF9533-B/DF", Philips, PAL,
@@ -244,7 +242,6 @@
           /* see tea5767.c for details */},
 	{ "Philips FMD1216ME MK3 Hybrid Tuner", Philips, PAL,
 	  16*160.00,16*442.00,0x51,0x52,0x54,0x86,623 },
-
 	{ "LG TDVS-H062F/TUA6034", LGINNOTEK, NTSC,
 	  16*160.00,16*455.00,0x01,0x02,0x04,0x8e,732},
 	{ "Ymec TVF66T5-B/DFF", Philips, PAL,

--=_431cb7f7.vJXezTg2CpppKkwodWxeYaA+rxCTlVraiI9EcOxUCuaeVKTt--
