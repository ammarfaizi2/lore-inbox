Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSDXLYa>; Wed, 24 Apr 2002 07:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSDXLY3>; Wed, 24 Apr 2002 07:24:29 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:9907 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311739AbSDXLY2>;
	Wed, 24 Apr 2002 07:24:28 -0400
Date: Wed, 24 Apr 2002 12:24:07 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.name>
X-X-Sender: <tigran@einstein.homenet>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST2][BUG] RAMFS broken in 2.4.19-pre7(-ac2)?
In-Reply-To: <Pine.LNX.4.44.0204241249170.8667-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0204241222320.3767-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:

> > On Wed, 24 Apr 2002, Roy Sigurd Karlsbakk wrote:
> > > # CONFIG_BLK_DEV_RAM is not set
> > > # CONFIG_BLK_DEV_INITRD is not set
> >
> > enable CONFIG_BLK_DEV_RAM and /dev/ram* will become useable. If you also
> > use initrd then enable CONFIG_BLK_DEV_INITRD as well.
>
> sorry - wrong .config-file. I thought the one I sent was identical to the
> one I used.

no, there must be yet another (3rd) .config file that was _actually_ used
for the kernel that you booted, because your /proc/devices didn't show the
ramdisk registered on major 1. Or did you use /proc/devices from some
other machine too? :)

Regards
Tigran

