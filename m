Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275385AbRIZRtd>; Wed, 26 Sep 2001 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbRIZRtU>; Wed, 26 Sep 2001 13:49:20 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:18304 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S275383AbRIZRsI>; Wed, 26 Sep 2001 13:48:08 -0400
Date: Wed, 26 Sep 2001 13:48:26 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac15 (double entries for DRI cards)
Message-ID: <Pine.LNX.4.33.0109261340560.1820-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In "Character Devices" when configuring the kernel using xconfig there are
double entries for video cards under Direct Rendering Manager.  The
following cards are reported twice:

3dfx Banshee/Voodoo3+
3dlabs GMX 2000
ATI Rage 128
ATI Radeon
Intel I810
Matrox G200/G400/G450

They menu is correct when doing menuconfig. They are only reported once.
The bug is repeatable.

kernel: 2.4.9 patched with 2.4.9-ac15.
gcc: 3.0.2 (snapshot)

Stephen

