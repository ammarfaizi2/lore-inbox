Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSKOSNz>; Fri, 15 Nov 2002 13:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSKOSNz>; Fri, 15 Nov 2002 13:13:55 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:9999 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S266638AbSKOSNt>; Fri, 15 Nov 2002 13:13:49 -0500
Message-ID: <YWxhbg==.d61dc67f3844853625a2fe40a185ce8c@1037384037.cotse.net>
Date: Fri, 15 Nov 2002 13:13:57 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: CD IO error
From: "Alan Willis" <alan@cotse.net>
To: <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1037383017.19987.44.camel@irongate.swansea.linux.org.uk>
References: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
        <1037383017.19987.44.camel@irongate.swansea.linux.org.uk>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - so the hdparm is fine, but the I/O error probably isnt

More info, if it helps.

/proc/ide/hdc/model
Lite-On LTN486 48x Max

/proc/ide/hdc/driver
ide-cdrom version 4.59

/proc/ide/hdc/identify
85a0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5944
3031 2020 2020 4c69 7465 2d4f 6e20 4c54
4e34 3836 2020 3438 7820 4d61 7820 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0200 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0007 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0002 0009 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0407 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

/proc/ide/hdc/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
current_speed           66              0               70              rw
dsc_overlap             0               0               1               rw
ide-scsi                0               0               1               rw
init_speed              66              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

It's on ide1

/proc/ide/ide1/config
pci bus 00 device f9 vendor 8086 device 2411 channel 1
86 80 11 24 05 00 80 22 02 80 01 01 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 11 24
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
07 e3 07 e3 00 00 00 00 05 00 02 02 00 00 00 00
00 00 00 00 11 04 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 3a 04 00 00 00 00 00 00

/proc/ide/piix

Controller: 0

                                Intel PIIX4 Ultra 66 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              no              yes               no
UDMA enabled:   4                X               2                 X
UDMA
DMA
PIO




