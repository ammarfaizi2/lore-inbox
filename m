Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbREMNnd>; Sun, 13 May 2001 09:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbREMNnX>; Sun, 13 May 2001 09:43:23 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:21265 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S261401AbREMNnP>; Sun, 13 May 2001 09:43:15 -0400
Date: Sun, 13 May 2001 06:42:44 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Art Boulatov <art@ksu.ru>
cc: mirabilos <eccesys@topmail.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for Microsoft dynamic disks?
In-Reply-To: <01051317225200.00874@artsystems.ksu.ru>
Message-ID: <Pine.LNX.4.32.0105130634260.1016-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All , I see one very big gotcha here .  M$ doesn't want you
	to have a linux partition on the drive they fdo this by not
	recognising your ext2/ext3/JFS/... partition .
	The next real difficulty is going to be for those that already
	have a linux system setup and are going to try & install M$-LDM on
	their drives & BANG!  no more ext2/... .  A work around such as Art
	describes below is VERY much needed & needs to be posted in all
	the right places .
	As an aside linux-kernel/... are going to hear at least a half a
	years worth of noise about it .  Sorry about the noise .  JimL

On Sun, 13 May 2001, Art Boulatov wrote:

> On Sunday 13 May 2001 03:15 pm, mirabilos wrote:
>
> > ................
> > I had (on a 2G disk) a NTFS, a FAT and some Linux partitions. It even
> > refused
> > to convert to dynamic disk. When it finally did, my Linux partitions
> > vanished.
> > You need this support to even be able to use linux on that disk... btw
> > .........................
>
> It is actiually possible to have both Linux and Windows 2000/Windows XP with
> dynamic disk on the same hard drive for now.
>
> The thing is you have first to install Windows XP, leaving  required space
> for the Linux install, and convert the drive to dynamic disk.
> When it is sucessfully converted you can reboot from linux floppy and "resize"
> the last partition on the disk to the place where the free space actually
> begins.
> Now it's possible to create some partitions here to install Linux.
> The point is Windows still thinks there is an unpartioned space there,
> where you just put your Linux distro :)
>
> But thats not the option anyway,
> and recognising dynamic disks would be a much better solution :).
>
> Art.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

