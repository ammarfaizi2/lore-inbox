Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314559AbSD0Cpp>; Fri, 26 Apr 2002 22:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314560AbSD0Cpo>; Fri, 26 Apr 2002 22:45:44 -0400
Received: from cambot.suite224.net ([209.176.64.2]:11023 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S314559AbSD0Cpo>;
	Fri, 26 Apr 2002 22:45:44 -0400
Message-ID: <003501c1ed96$4aba86a0$aef583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Steve Kieu" <haiquy@yahoo.com>, "kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427020728.18534.qmail@web10406.mail.yahoo.com>
Subject: Re: UFS in 2.4.19-pre
Date: Fri, 26 Apr 2002 22:50:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having the same problem mounting my Darwin Partition with 2.5.8. I have
not  patched the source up to 2.5.9 or 2.5.10 as yet.

Matthew
----- Original Message -----
From: "Steve Kieu" <haiquy@yahoo.com>
To: "kernel" <linux-kernel@vger.kernel.org>
Sent: Friday, April 26, 2002 10:07 PM
Subject: UFS in 2.4.19-pre


>
> Hi,
>
> I can not mount a working free bsd file system, with
> 2.4.19-pre2 and 2.4.19-pre4-ac4  not sure for other
> version.
>
> #mount -t ufs /dev/hda6 /mnt/disk/
> mount: wrong fs type, bad option, bad superblock on
> /dev/hda6,  or too many mounted file systems
>
> Run fdisk
>
> Disk /dev/hda: 255 heads, 63 sectors, 1245 cylinders
> Units = cylinders of 16065 * 512 bytes
>
>    Device Boot    Start       End    Blocks   Id
> System
> /dev/hda1             1         9     72261   82
> Linux swap
> /dev/hda2   *        10       227   1751085    b
> Win95 FAT32
> /dev/hda3           228       355   1028160   83
> Linux
> /dev/hda4           356      1245   7148925   a5
> BSD/386
>
> Command (m for help):
> I tried all mount options, ro, ufstype=44bsd  etc  but
> all I got is the same messaage
>
> did anyone see it before? What should I do to read
> from this partition from Linux, as u can see this is
> the bigest one, and I dont want to delete the whole
> freebsd by now, at least until they (freebsd people)
> have fixes the i810 audio driver so I can test again.
> At the moment I have to boot freebsd to transfer files
> from ext2 between...
>
> Thanks in advance.
>
>
> =====
> Steve Kieu
>
> http://messenger.yahoo.com.au - Yahoo! Messenger
> - A great way to communicate long-distance for FREE!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

