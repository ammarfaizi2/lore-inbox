Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSDXL6k>; Wed, 24 Apr 2002 07:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSDXL6j>; Wed, 24 Apr 2002 07:58:39 -0400
Received: from mustard.heime.net ([194.234.65.222]:33191 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S311641AbSDXL6j>; Wed, 24 Apr 2002 07:58:39 -0400
Date: Wed, 24 Apr 2002 13:58:34 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Tigran Aivazian <tigran@aivazian.name>
cc: linux-kernel@vger.kernel.org
Subject: Re: [REPOST2][BUG] RAMFS broken in 2.4.19-pre7(-ac2)?
In-Reply-To: <Pine.LNX.4.33.0204241222320.3767-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0204241357230.8961-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Too much mess.

Of course, the /proc/devices was from my computer, compiled without proper 
ramfs support. I don't have /proc/devices from the other one, as I can't 
boot it, lacking RAMFS support.

sorry about this

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

