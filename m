Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUA2K2a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265587AbUA2K2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:28:30 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:41091 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S264542AbUA2K22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:28:28 -0500
Date: Thu, 29 Jan 2004 11:28:21 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: IDE questions [kernel: 2.6.1-rc1]
Message-Id: <20040129112821.27b59313@phoebee>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.8claws54 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.0-test4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__29_Jan_2004_11_28_21_+0100_HTH7oMv6K3AJPnww"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__29_Jan_2004_11_28_21_+0100_HTH7oMv6K3AJPnww
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there,

2 questions about IDE:

1.: with my machine:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-00CAA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
cdrom: : unknown mrw mode page
      ^ no cdi->name?
        is this for the hda device or hdc?

hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20


2.: with another machine:
I have a disk that has some bad sectors (that says the drive fitness test from
ibm). and I think one of the sectors is where the partition table is.
on kernel boot the kernel stops when it tries to detect the partitions and
gives some "dma timeout"s.
can I disable the partition table probe? is the "hdx=noprobe" argument the right
one?


Regards,
Martin


ps.: sorry for my bad english

-- 
MyExcuse:
halon system went off and killed the operators.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__29_Jan_2004_11_28_21_+0100_HTH7oMv6K3AJPnww
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGOBFmjLYGS7fcG0RAn9NAJ4untolBYYzlnQIPLYD1vwqhYorvwCgrwVH
hgPBwwtJTY27JpYpzjU074s=
=E7he
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Jan_2004_11_28_21_+0100_HTH7oMv6K3AJPnww--
