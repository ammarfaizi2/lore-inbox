Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbQLFUUz>; Wed, 6 Dec 2000 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbQLFUUp>; Wed, 6 Dec 2000 15:20:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:11274
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130682AbQLFUUh>; Wed, 6 Dec 2000 15:20:37 -0500
Date: Wed, 6 Dec 2000 11:36:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Skip Collins <bernard.collins@jhuapl.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E51B0.76C65771@jhuapl.edu>
Message-ID: <Pine.LNX.4.10.10012061128520.21407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have not tested of checked the nature of the PCD20265 which is the
onboard version.


On Wed, 6 Dec 2000, Skip Collins wrote:

> After running 2.4.0-test11 for a while, my system would occasionally
> hang during heavy disk activity resulting in a corrupt ext2 filesystem.
> Fortunately, none of the damage has been irrecoverable. I checked
> linux-kernel to see if anyone else was seeing the same thing. The recent
> threads on corruption seemed to be consistent with the behavior I saw:
> ide disk access light remains lit, system hangs, fsck finds bad inodes.
> I think test12-pre5 was supposed to fix the problem. But after upgrading
> my kernel, I can still get the errors. 
> 
> I have a 900MHz Athlon/Asus A7V mobo system with an onboard ata100
> promise controller. I have only had problems when my ata100/udma5
> harddrive is connected to the promise controller. Using the ATA66 ide
> bus eliminates the problem. I typically see the corruption when copying
> large (~1GB) files such as vmware virtual disks. It also happens
> frequently inside vmware when doing heavy disk access things like
> installing software or defragging a win2000 virtual disk.
> 
> For now I am going to fall back to the slower ide bus. But I wanted to
> let people know that there still may be problems with ext2 corruption in
> the latest test kernel.
> 
> sc
> please cc any replies to me
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
