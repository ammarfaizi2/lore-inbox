Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281705AbRKUWlo>; Wed, 21 Nov 2001 17:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281703AbRKUWle>; Wed, 21 Nov 2001 17:41:34 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:41408 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281705AbRKUWl2>; Wed, 21 Nov 2001 17:41:28 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: Re: Again Multiboot-Standard for Linux ?
Date: Wed, 21 Nov 2001 23:41:22 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D772@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D772@orsmsx111.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <166g3I-0ksq00C@fwd06.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > From: "ChristianK."@t-online.de [mailto:"ChristianK."@t-online.de]
> >
> > Is anyone still working on making the Linux Kernel Multiboot
> > compliant ?
>
> Was someone working on this before? It didn't seem like it.

You can find some references in the unoffical Kernel-Mailing list Archive, 
and there was a Patch for the 1.2.x Kernel series to make it Multiboot 
compliant, but I don't know what has happend to this.

> > I wan't to load my modules from grub(pxegrub) without the
> > need to compile in
> > ramdisk / initrd / romfs... (System memory is very low (4MB-6MB)).
>
> I am tentatively looking at this, but for other reasons. IIRC the initrd's
> memory is recycled later on, so I don't know if tight memory is a good
> reason for pursuing this.

I know that the ramdisk memory is reused, but not the memory needed for the 
ramdisk , and the romfs/minix,ext2... whatever filesystem code.

Beside that, this it is a very nice feature for making an Installation Disk / 
Distributions.
AFAIK the newest RedHat distribution use grub as standard Linux Loader,
if the Linux Kernel is able to load modules before mounting root, you can 
make a Kernel without any block/bus driver compiled in.

All i want to know is if anybody is still working on this, before i start 
coding myselve (I hate doing things twice).

Mfg. Christian König.
PS: Sorry for my poor English.

