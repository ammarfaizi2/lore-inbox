Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311741AbSCNTWo>; Thu, 14 Mar 2002 14:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311742AbSCNTWZ>; Thu, 14 Mar 2002 14:22:25 -0500
Received: from netmail.netcologne.de ([194.8.194.109]:49962 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S311741AbSCNTWN>; Thu, 14 Mar 2002 14:22:13 -0500
Message-Id: <200203141922.AUR79517@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre2-jp7 #1 Fre =?iso8859-15?q?M=E4r=208=2021=3A37=3A18=20CET=202002=20i686?= unknown
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Patch set 2.4.19-pre3-jp8
Date: Thu, 14 Mar 2002 20:21:22 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel patch set jp8 based on Linux kernel 2.4.19-pre3

What is it?

The -jp kernels are development kernels for testing purpose only. 
They will appear regularly two or three times a month. Their purpose 
is to provide a service for developers who can't keep up to date with 
the latest kernel and patch versions, but want to test new features 
and evaluate enhancements that are not to be expected for inclusion 
into the mainstream 2.4 kernel.

You want to test the kernel patch set? Download the standard kernel 2.4.18,
and apply the jp8 set.

You are missing a patch? Patches will be added by request.

You run into problems? Send me a mail and I will try to fix the problem.
I want to get the jp kernels as much as stable I can.

You feel happy with a jp kernel? Just let me know if my work is good for you.

On my system I only use jp kernels. So, some minor features are specific
to Dell Inspiron laptops.

Changes 

jp7 to jp8:

2.4.19pre3 - standard kernel (Marcelo Tosatti)
2.4.19pre3 quick fixes - some quick hacks from lkml to make pre3 work
alsa - backport of ALSA 0.9.0beta 12 (from 2.5.6) plus "no modem codec probe"
       patch for Dell Inspiron 8100 (me)
supermount - minor fix to compile supermount (me)
ftpfs - FTP kernel client (Florin Malita)
cdfs - CD audio file system (Michiel Ronsse)
xfs - CVS status as of 13 March 2002 (XFS team)
jfs - IBM's journal file system version 1.0.16 (JFS team)

Overview

00_patch-2.4.19-pre0-pre1.bz2
00_patch-2.4.19-pre1-pre2.bz2
00_patch-2.4.19-pre2-pre3.bz2
00_patch-2.4.19-pre3-quickfixes.bz2
01_kernel-sound-remove-0-2.4.19pre3.bz2
01_kernel-sound-remove-1-2.4.19pre2.bz2
01_kernel-sound-remove-2-core.bz2
02_alsa-0.9.0beta10-0.bz2
02_alsa-0.9.0beta10-beta12-include.bz2
02_alsa-0.9.0beta10-beta12-sound.bz2
02_alsa-0.9.0beta12-addon.bz2
02_alsa-0.9.0beta12-no-modem-probe.bz2
03_boot-time-ioremap.bz2
03_dmi-apic-fixups.bz2
11_rmap12g.bz2
11_sched-O1-K3.bz2
12_preempt-kernel-rml-2.4.19-pre2-ac2-3.bz2
14_lockbreak-rml.bz2
15_lockbreak-addon.bz2
22_autofs4.bz2
22_isrdonly.bz2
22_new-stat.bz2
23_mediactl.bz2
24_llseek.bz2
25_mount.bz2
26_device.bz2
27_supermount-0.bz2
27_supermount-1-addon.bz2
28_raidsplit.bz2
29_mdp-major.bz2
29_mdpart.bz2
30_xfs-kdb-13Mar2002.bz2
31_xfs-kdb-addon.bz2
32_jfs-1.0.14-common.bz2
33_jfs-1.0.14-1.0.15.bz2
33_jfs-1.0.15-to-1.0.16.bz2
34_jfs-addon.bz2
35_ftpfs-0.6.2.bz2
36_cdfs-0.5b.bz2
40_TIOCGDEV.bz2
41_twofish-2.4.3.bz2
50_crypto-patch-int-2.4.18.1-addon.bz2
50_crypto-patch-int-2.4.18.1.bz2
51_loop-jari-2.4.16.0.bz2
60_freeswan-1.95-x509-0.9.8.bz2
70_grsecurity-1.9.4-1.bz2
71_grsec-addon.bz2
72_linux-2.4.18.secfix.bz2
80_i2c-2.6.2.bz2
81_lmsensors-2.6.2.bz2
84_sdmany-v3.bz2
98_tkparse-4096.bz2
99_VERSION

Download

http://infolinux.de/jp8

Known Problems

In jp6, crypted home directories did not work. This is still untested in jp8.

cdfs oopses when reading toc from CD.

Jörg Prante <joerg@infolinux.de>
