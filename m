Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbTBEI02>; Wed, 5 Feb 2003 03:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbTBEI02>; Wed, 5 Feb 2003 03:26:28 -0500
Received: from [202.54.64.7] ([202.54.64.7]:21513 "EHLO hclnpd.hclt.co.in")
	by vger.kernel.org with ESMTP id <S267857AbTBEI01>;
	Wed, 5 Feb 2003 03:26:27 -0500
Message-ID: <3E418AD0.BC9F9765@npd.hcltech.com>
Date: Wed, 05 Feb 2003 14:06:08 -0800
From: Narsimha Reddy CHALLA <creddy@npd.hcltech.com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to install two linux OSes on the same PC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  All,

    I want to do two different linux installations rh 7.2 and rh 
8.0 on the same pc with single hard disk. I installed the rh 7.2 in
partitions say  /dev/hda5 ( /) ,  /dev/hda6  (/home) ,  /dev/hda7 (
/usr) ,
/dev/hda8 ( /tmp),... /dev/hda11  etc. 

   But how can I install the rh 8.0 in partitions say  /dev/hda12
( as "/" )  ... etc ??  Since the installer won't allow as there
already exists a  "/"  partition for the rh 7.2 and tries to override
it with the root partition of rh 8.0. So I tried giving a different
lable to the root partition of rh 8.0 say /root1 and other partitions
as /root1/usr, /root1/home, /root1/tmp etc. But here also the installer
is looking for the partition named "/" and without that the installation
is not happening. 


Please give your suggestions on how to resolve this problem.


At present my partition table with single installation (rh 7.2)  is,

[root@creddy-pc root]# fdisk -l

Disk /dev/hda: 255 heads, 63 sectors, 2434 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       261   2096451    6  FAT16
/dev/hda2           262      2434  17454622+   5  Extended
/dev/hda5           262       522   2096451    6  FAT16
/dev/hda6           523       653   1052226   83  Linux
/dev/hda7           654      1175   4192933+  83  Linux
/dev/hda8          1176      1371   1574338+  83  Linux
/dev/hda9          1372      1436    522081   82  Linux swap
/dev/hda10         1437      1501    522081   83  Linux
/dev/hda11         1502      1566    522081   83  Linux
[root@creddy-pc root]#


TIA,
- Narsimha Reddy CH
