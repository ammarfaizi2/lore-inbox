Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSDXLZs>; Wed, 24 Apr 2002 07:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311829AbSDXLZr>; Wed, 24 Apr 2002 07:25:47 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:24759 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311752AbSDXLZp>;
	Wed, 24 Apr 2002 07:25:45 -0400
Date: Wed, 24 Apr 2002 12:25:29 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.name>
X-X-Sender: <tigran@einstein.homenet>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST2][BUG] RAMFS broken in 2.4.19-pre7(-ac2)?
In-Reply-To: <Pine.LNX.4.33.0204241222320.3767-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0204241224480.3767-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also, I assume you checked the obvious, i.e. whether size 24000 is valid.
try booting with ramdisk_size=16384 to verify (it should work, I use it
all the time).

On Wed, 24 Apr 2002, Tigran Aivazian wrote:

> On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:
>
> > > On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:
> > > > # CONFIG_BLK_DEV_RAM is not set
> > > > # CONFIG_BLK_DEV_INITRD is not set
> > >
> > > enable CONFIG_BLK_DEV_RAM and /dev/ram* will become useable. If you also
> > > use initrd then enable CONFIG_BLK_DEV_INITRD as well.
> >
> > sorry - wrong .config-file. I thought the one I sent was identical to the
> > one I used.
>
> no, there must be yet another (3rd) .config file that was _actually_ used
> for the kernel that you booted, because your /proc/devices didn't show the
> ramdisk registered on major 1. Or did you use /proc/devices from some
> other machine too? :)
>
> Regards
> Tigran
>
>

