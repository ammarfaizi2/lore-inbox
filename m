Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312255AbSDKQtQ>; Thu, 11 Apr 2002 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDKQtP>; Thu, 11 Apr 2002 12:49:15 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:55340 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S312255AbSDKQtP>; Thu, 11 Apr 2002 12:49:15 -0400
From: Frank Krauss <fmfkrauss@mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: Possible EXT2 File System Corruption in Kernel 2.4
Date: Thu, 11 Apr 2002 12:40:15 -0400
X-Mailer: KMail [version 1.0.21]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E16vKwg-00056q-00@barry.mail.mindspring.net>
MIME-Version: 1.0
Message-Id: <02041112492500.01786@sevencardstud.cable.nu>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I have a problem in the area of EXT2 File System Corruption.

I attempted originally to send this information to Remy Card as per the
MAINTAINERS file at RemyCard@linux.org but I got the message about
him being an unknown user.

Since my System is fairly up-to-date, both Hardware and Software wise,
I thought that perhaps someone would be able to solve this problem of mine. 

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
> Hello Remy,
> 
> I have a problem which appears to be in your area of responsibility and expertise.
> 
> Hardware Information
> 
> 1.  I have a Pentium 4 P.C.
> 2.  The Motherboard is a D850MV.
> 3.  The Chipset is an Intel 850.
> 4.  The System has 256 Mb of Ram.
> 5.  My Hard-drive is a Maxtor 5T030H3 (30 gigibytes)
> 6.  It is on ide1 as /dev/hdc.
> 7.  The disk is Partitioned in the following manner:
>                                 C y l s      Usage              1K Blks
>     A.  /dev/hdc1        1 -   85      Root                660890
>     B.  /dev/hdc2      86 -  150      Swap
>     C.  /dev/hdc3   151 - 3671      /Products      27015180
>     D.  /dev/hdc4 3672 - 3736      /Source            505471
> 
> Software Information
> 
> 1.  My Linux Distribution is Caldera 2.3
> 2.  I have upgraded the Kernel to 2.4.18
> 
> My problem came up yesterday in the following manner:
> My Root Partition, /dev/hdc1 went 100% full.
> Even though I erased various files from it which should have brought
> it down to 97% usage, it remained at the 100% level.
> I believe that this is another, known, separate problem from mine.
> 
> I finally decided to move the /usr/X11R6 directory, which was approx. 134 Mb,
> from the /root partition to a completly empty partition that I had just
> defined as /Products on /dev/hdc3. 
> 
> The Copy worked but I got the following 10 Error Messages:
> 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835885 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835886 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835894 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835902 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835910 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835918 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835926 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835934 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835942 
> Apr  9 17:12:51 kernel: EXT2-fs error (device ide1(22,3)): ext2_new_block: Allocating block in system zone - block = 835950 
> 
> Since I did a DU of both the Old and New directories and they were the same,
> I assumed that everything was O.K.
> 
> Unfortunately, after I shutdown the System and re-booted, I got a huge number 
> of INODE error messages that took FSCK about an Hour to fix.
> I did not write any of the Inode information down.
> 
> I see mention on the Net that up to 2.4.17 there are still problems outstanding
> in this area of the Kernel.
> 
> Would you be kind enough to tell me if there is any fix I can put on my
> System to keep this problem from reoccuring again?
> 
> As my System is currently a Testing/Development System, I would be quit happy
> to help you debug this problem with any reasonable testing that you would like
> me to do.
> 
> Alan Cox mentioned, in a response to someone who had a similar problem as
> mine, that a VIA Chipset along with a Sound Blaster Live card, could somehow
> cause this problem.
> 1.   I do NOT have the VIA Chipset on my System.
> 2.   I DO have the Sound Blaster Live card on my System.
> 
> I didn't have this problem using Kernel 2.2.17 on my 486 Computer.
> 
> I would like to get this problem resolved before my System becomes Production
> since I value Reliability and Stability of an Operating System most importantly
> of all.
> 
> I will be glad to provide you any additional information about my System that
> would assist you in solving this problem.
> 
> I would like to thank you in advance for your effort in clearing up this 
> problem effecting the reliability of the New Production Linux Kernel.
> 
> Yours truly,
> 
> Frank Krauss
               
