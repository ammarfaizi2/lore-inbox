Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262872AbSJLJ07>; Sat, 12 Oct 2002 05:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbSJLJ07>; Sat, 12 Oct 2002 05:26:59 -0400
Received: from f182.law11.hotmail.com ([64.4.17.182]:64521 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262872AbSJLJ04>;
	Sat, 12 Oct 2002 05:26:56 -0400
X-Originating-IP: [193.219.143.91]
From: "Roman Lenskij" <romanlenskij@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug on Mdk 9.0
Date: Sat, 12 Oct 2002 09:32:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F182igPasSmz6UuEhjJ000001bb@hotmail.com>
X-OriginalArrivalTime: 12 Oct 2002 09:32:39.0705 (UTC) FILETIME=[4EB06890:01C271D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System AMD Athlon ThunderBird 800mhz
384 mb-ram
Nvidia Ge-Force 2 MX (with 3123 nvidia drivers(GLX.RPM & 
NVIDIA_KERNEL.SRC.rPM)
Fujitsu HDD - 20GB 7200 RPM
Linux Mandrake 9.0
Kernel 2.4.19-16mdk
KDE 3.0.4

when configuring system ( console mod and X), system starts working like so
2 sec every thing stops responding, then 1 every thing responds again and so 
on (i speak about Mouse & Keyboard & Sound)
i noticed this bug when i first configured my system ( AFTER INSTALL !!!!)

if u're in console (terminal) mode u can c this messages

Oct  9 13:52:14 rll kernel: udf: bad mount option "codepage=850"
Oct  9 13:53:04 rll kernel: udf: bad mount option "codepage=850"
Oct  9 13:54:05 rll last message repeated 5 times
Oct  9 13:56:53 rll last message repeated 3 times
Oct  9 14:41:42 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct  9 14:41:42 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct  9 14:42:13 rll last message repeated 647 times
Oct  9 14:43:15 rll last message repeated 1125 times
Oct 10 18:18:27 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 10 18:18:27 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 10 18:18:59 rll last message repeated 570 times
Oct 11 12:52:24 rll kernel: udf: bad mount option "codepage=850"
Oct 11 13:52:05 rll kernel: udf: bad mount option "codepage=850"
Oct 11 18:46:41 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 11 18:46:41 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 11 18:47:13 rll last message repeated 539 times
Oct 12 00:31:43 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 00:31:43 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 00:32:15 rll last message repeated 539 times
Oct 12 00:54:01 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 00:54:01 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 00:54:33 rll last message repeated 539 times
Oct 12 00:57:27 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 00:57:27 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 01:00:24 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 01:00:24 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 01:00:56 rll last message repeated 539 times
Oct 12 01:03:37 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 01:03:37 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 01:04:09 rll last message repeated 539 times
Oct 12 09:06:03 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 09:06:03 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 09:06:35 rll last message repeated 539 times
Oct 12 09:07:00 rll last message repeated 458 times
Oct 12 09:07:00 rll kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000003
Oct 12 09:07:00 rll kernel: *pde = 00000000
Oct 12 09:07:00 rll kernel: *pde = 00000000
Oct 12 09:07:00 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 09:21:57 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 09:21:57 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 09:41:03 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 09:41:03 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 10:18:34 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 10:18:34 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted

after that there are a lot of HEX symbols( if i catch em again i'll send u a 
copy)
then there's a message Aii!!! (or smth like that) then there's message that 
kernel is kaput, kirdik, died. then (if ur in X mode) system self restarts, 
else stops reponding PLZ send me a reply ( i turned off SCSI support in 
kernel conf, but this happened again)

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

