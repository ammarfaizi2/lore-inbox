Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTBIJxc>; Sun, 9 Feb 2003 04:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbTBIJxc>; Sun, 9 Feb 2003 04:53:32 -0500
Received: from krynn.axis.se ([193.13.178.10]:59553 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S267183AbTBIJxb>;
	Sun, 9 Feb 2003 04:53:31 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE762@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Nandakumar  NarayanaSwamy'" <nanda_kn@rediffmail.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: File systems in embedded devices
Date: Sun, 9 Feb 2003 11:03:10 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We use JFFS2 for configuration parameters etc, cramfs for 
binaries etc  and tmpfs for temporary data (our embedded 
devices typically have 4 MB flash and 16 MB RAM).

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Nandakumar
NarayanaSwamy
Sent: Saturday, February 08, 2003 3:20 PM
To: linux-kernel@vger.kernel.org
Subject: File systems in embedded devices


Dear All,

We are developing a embedded device based on linux. Through the 
development phase we used NFS. But now we want to move some 
filesystem
which can be created in FLASH/RAM.

I have few doubts about the file system in embedded devices.

1) What is the file system which is used normally in all embedded 
devices? (JFFS/CRAMFS/RAM DISK)

2) We tried using RAM disk as the file system. But since our 
application is huge it is not able to fit into 8 MB RAM disk 
created. When we tried to increase the size of the RAM disk, the 
kernel crashes above 9 MB. We have 32 MB in our target board.

3) I dont know whether we can use cramfs.

Can anybody suggest me some ideas so that i can solve these 
issues?

Thanks and Regards,
Nanda

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
