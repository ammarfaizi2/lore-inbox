Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279730AbRJYIty>; Thu, 25 Oct 2001 04:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279729AbRJYIto>; Thu, 25 Oct 2001 04:49:44 -0400
Received: from rosebud.imaginos.net ([64.173.180.66]:1920 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S279730AbRJYIte>; Thu, 25 Oct 2001 04:49:34 -0400
Date: Thu, 25 Oct 2001 01:49:39 -0700 (PDT)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: <linux-kernel@vger.kernel.org>
Subject: dvd and filesystem errors under 2.4.13
Message-ID: <Pine.LNX.4.33.0110250138380.1704-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

	After installing 2.4.13 this afternoon i decided to watch a dvd,
intersting enough the dvd kept freezing, to be sure it wasn't the player,
i raw copied the vob files from the mounted dvd and I saw the same
occurance. My wife's machine and my laptop both are currently running 2.4.9 and
use the same dvd player and were not having any problem, so for shits and
giggles i downgraded this machine to 2.4.9 and the error has disappeared.
Also over the past few days (between 2.4.11 - 2.4.13) I have noticed an
increase in filesystem errors and drive errors on my scsi drives as notes:

Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
ext2_free_blocks: bit already cleared for block 133384
Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
ext2_free_blocks: bit already cleared for block 133385


The hardware is as follows ....

scsi devices with filesystem errors:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
  Vendor: SEAGATE   Model: ST39103LW         Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 02

dvd device:
hdc: SAMSUNG DVD-ROM SD-604, ATAPI CD/DVD-ROM drive

I think that should cover it and hopefuly I have provided enough
information to possibly debug the problem ?


============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE719I1dygyS8O4zQ0RAub/AKCeOholXyzJZ4ShqyT1b7sYdgG4LACfbeGk
UPiGbo7wDvzMUAzkOJXHAHQ=
=Iwcl
-----END PGP SIGNATURE-----


