Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbTA1RBc>; Tue, 28 Jan 2003 12:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTA1RBc>; Tue, 28 Jan 2003 12:01:32 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:33031 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S267417AbTA1RBb>; Tue, 28 Jan 2003 12:01:31 -0500
Message-Id: <5.1.1.6.2.20030128180909.02545fe0@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Tue, 28 Jan 2003 18:10:50 +0100
To: linux-kernel@vger.kernel.org
From: "alberto.rodriguez@nullzone.org" <alberto.rodriguez@nullzone.org>
Subject: Kernel and BIOS doesnt give same info about IDE disks here
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



After install a 2.5.59 from a 2.4.20 i am getting this message just running 
lilo:
------------------------------------------------------

server01:/home2# lilo
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x81
     fn 08: 1024 cylinders, 255 heads, 63 sectors
     fn 48: 16383 cylinders, 16 heads, 63 sectors
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x82
     fn 08: 1024 cylinders, 255 heads, 63 sectors
     fn 48: 16383 cylinders, 16 heads, 63 sectors
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x83
     fn 08: 1024 cylinders, 255 heads, 63 sectors
     fn 48: 16383 cylinders, 16 heads, 63 sectors
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x84
     fn 08: 1024 cylinders, 255 heads, 63 sectors
     fn 48: 16383 cylinders, 16 heads, 63 sectors
Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
     Kernel: 5086 cylinders, 16 heads, 63 sectors
       BIOS: 635 cylinders, 128 heads, 63 sectors
Added current
Added 2.4.21-pre2
Added 2.5.59 *

--------------------------

any idea?
need more info?

