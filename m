Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSCHXNJ>; Fri, 8 Mar 2002 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSCHXNA>; Fri, 8 Mar 2002 18:13:00 -0500
Received: from m1000.netcologne.de ([194.8.194.104]:29985 "EHLO
	m1000.netcologne.de") by vger.kernel.org with ESMTP
	id <S286343AbSCHXMo>; Fri, 8 Mar 2002 18:12:44 -0500
Message-Id: <200203082312.ALR01187@m1000.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre2-jp7 #1 Fre =?iso8859-15?q?M=E4r=208=2021=3A37=3A18=20CET=202002=20i686?= unknown
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Kernel patch set 2.4.19-pre2-jp7
Date: Sat, 9 Mar 2002 00:12:17 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel patch set jp7 based on Linux kernel 2.4.19-pre2 released

What is it?

The -jp kernels are development kernels for testing purpose only. 
They will appear regularly two or three times a month. Their purpose 
is to provide a service for developers who can't keep up to date with 
the latest kernel and patch versions, but want to test new features 
and evaluate enhancements that are not to be expected for inclusion 
into the mainstream 2.4 kernel.

You want to test the kernel patch set? Download the standard kernel 2.4.18,
and apply the jp7 set.

You are missing a patch? Patches will be added by request.

You run into problems? Send me a mail and I will try to fix the problem.
I want to get the jp kernels as much as stable I can.

You feel happy with a jp kernel? Just let me know if my work is good for you.

On my system I only use jp kernels. So, some minor features are specific
to Dell Inspiron laptops.

Changes 

jp6 to jp7:

2.4.19pre2 - standard kernel (Marcelo Tosatti)
alsa - backport of 2.5.4 Advanced Linux Sound Architecture to 2.4.19pre2 (me)
rmap12g - supersedes rmap12f (Rik van Riel)
preempt - preempt UP fix (Robert Love)
supermount - stable supermount for 2.4 (Juan Jose Quintela) 
xfs - CVS status as of 7 March 2002, now with quota (XFS team)
crypto - cryptographic API for 2.4.18 (Herbert Valerio Riedel)
grsecurity 1.9.4 - release version of the best security patch set (Brad 
Spengler)
secfix - security fix, prevents process kills by local users (Brad Spengler)
sdmany - many SCSI devices (Richard Gooch)

Overview

00_patch-2.4.19-pre0-pre1.bz2
00_patch-2.4.19-pre1-pre2.bz2
01_kernel-sound-core-remove.diff.bz2
01_kernel-sound-remove-2.4.19pre2.diff.bz2
02_alsa-backport-2.5.4-2.4.18.patch.bz2
02_alsa-backport-addon.diff.bz2
03_boot-time-ioremap.bz2
03_dmi-apic-fixups.bz2
03_early-dmi-scan.bz2
11_rmap12g.bz2
11_sched-O1-K3.bz2
12_preempt-kernel-rml-2.4.19-pre2-ac2-3.patch.bz2
14_lockbreak-rml.bz2
15_lockbreak-addon.bz2
20_ide.bz2
21_ide-addon.bz2
22_autofs4.patch.bz2
22_isrdonly.patch.bz2
22_new-stat.patch.bz2
23_mediactl.patch.bz2
24_llseek.patch.bz2
25_mount.patch.bz2
26_device.patch.bz2
27_supermount.patch.bz2
28_raidsplit.bz2
29_mdp-major.bz2
29_mdpart.bz2
30_xfs-kdb-07032002.diff.bz2
31_xfs-kdb-addon.bz2
32_jfs-1.0.14-common.bz2
33_jfs-1.0.14-1.0.15.bz2
34_jfs-addon.bz2
40_TIOCGDEV.bz2
41_twofish-2.4.3.bz2
50_crypto-patch-int-2.4.18.1-addon.bz2
50_crypto-patch-int-2.4.18.1.bz2
51_loop-jari-2.4.16.0.patch.bz2
60_freeswan-1.95-x509-0.9.8.patch.bz2
70_grsecurity-1.9.4-1.bz2
71_grsec-addon.bz2
72_linux-2.4.18.secfix.patch.bz2
80_i2c-2.6.2.patch.bz2
81_lmsensors-2.6.2.patch.bz2
84_sdmany-patch-v3.bz2

Download

http://infolinux.de/jp7

Known Problems

In jp6, crypted home directories did not work. This is untested in jp7.

The Alsa backport produces kernel messages while running xmms with mp3's: 
Mar  8 23:58:41 jungle kernel: ALSA pcm_lib.c:118: Unexpected hw_pointer 
value (stream = 0, delta: -1024, max jitter = 8192): wrong interrupt 
acknowledge?
I don't know what is happening, but it seems there is no effect, since
audio is good and uninterrupted. It's always noticed in full minute 
intervals but not regularly. If anyone can give me a hint?

Please CC, I'm not subscribed to lkml.

Jörg Prante <joerg@infolinux.de>
