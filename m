Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261285AbSJON3f>; Tue, 15 Oct 2002 09:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSJON3f>; Tue, 15 Oct 2002 09:29:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46280 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261285AbSJON3e>; Tue, 15 Oct 2002 09:29:34 -0400
Date: Tue, 15 Oct 2002 15:35:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Roman Zippel <zippel@linux-m68k.org>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel conf 0.9
In-Reply-To: <3DAB23CB.5B52ECF1@linux-m68k.org>
Message-ID: <Pine.NEB.4.44.0210151528310.20607-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

I do always get the following segfault:

<--  snip  -->

$ cd /tmp/
$ tar xzf lkc-0.9.tar.gz
$ cd lkc-0.9
$ make
...
$ cd ~/linux/kernel-2.5
$ tar xzf linux-2.5.42.tar.gz
$ cd linux-2.5.42
$ bzcat /tmp/lkc-0.9-2.5.42.diff.bz2 |patch -p1
...
$ /tmp/lkc-0.9/lkcc i386
...
undefined symbol ARCH_ACORN
undefined symbol IA64
undefined symbol BAGET_MIPS
undefined symbol IA32_EMULATION
undefined symbol RPXCLASSIC
undefined symbol IT8172_REVC
recursive dependency: ISDN_DRV_EICON_DIVAS ISDN_DRV_EICON_OLD (choice(2) detected) ISDN_DRV_EICON_DIVAS
recursive dependency: AEDSP16_MSS AEDSP16_SBPRO (choice(1) detected) AEDSP16_MSS
recursive dependency: INPUT_GAMEPORT INPUT_GAMEPORT
recursive dependency: SCSI_AIC7XXX_OLD SCSI_AIC7XXX (choice(2) detected) SCSI_AIC7XXX_OLD AIC7XXX_BUILD_FIRMWARE
Segmentation fault
$

<--  snip  -->

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed



