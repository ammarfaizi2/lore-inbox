Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRLDDYc>; Mon, 3 Dec 2001 22:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283593AbRLCXqX>; Mon, 3 Dec 2001 18:46:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:55247 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S284407AbRLCK2f>; Mon, 3 Dec 2001 05:28:35 -0500
Date: Mon, 3 Dec 2001 11:28:30 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Riccardo Facchetti <fizban@tin.it>
cc: linux-kernel@vger.kernel.org
Subject: [patch] s|sound/lowlevel/aedsp16.c|sound/aedsp16.c|
Message-ID: <Pine.NEB.4.43.0112031122010.11219-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riccardo,

the patch below (against 2.4.17-pre2) corrects three files that referred
to the old location of aedsp16.c


--- drivers/sound/aedsp16.c.old	Mon Dec  3 11:22:05 2001
+++ drivers/sound/aedsp16.c	Mon Dec  3 11:22:20 2001
@@ -1,5 +1,5 @@
 /*
-   drivers/sound/lowlevel/aedsp16.c
+   drivers/sound/aedsp16.c

    Audio Excel DSP 16 software configuration routines
    Copyright (C) 1995,1996,1997,1998  Riccardo Facchetti (fizban@tin.it)
--- Documentation/sound/AudioExcelDSP16.old	Mon Dec  3 11:19:41 2001
+++ Documentation/sound/AudioExcelDSP16	Mon Dec  3 11:19:56 2001
@@ -2,7 +2,7 @@
 ------

 Informations about Audio Excel DSP 16 driver can be found in the source
-file lowlevel/aedsp16.c
+file aedsp16.c
 Please, read the head of the source before using it. It contain useful
 informations.

--- Documentation/Configure.help.old	Mon Dec  3 11:10:53 2001
+++ Documentation/Configure.help	Mon Dec  3 11:18:01 2001
@@ -18367,7 +18367,7 @@
   questions.

   Read the <file:Documentation/sound/README.OSS> file and the head of
-  <file:drivers/sound/lowlevel/aedsp16.c> as well as
+  <file:drivers/sound/aedsp16.c> as well as
   <file:Documentation/sound/AudioExcelDSP16> to get more information
   about this driver and its configuration.


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

