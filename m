Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284037AbRLOWdq>; Sat, 15 Dec 2001 17:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284079AbRLOWdh>; Sat, 15 Dec 2001 17:33:37 -0500
Received: from [195.66.192.167] ([195.66.192.167]:13320 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S284037AbRLOWd0>; Sat, 15 Dec 2001 17:33:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: pivot_root and initrd kernel panic woes
Date: Sun, 16 Dec 2001 00:32:31 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112151856190.381-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0112151856190.381-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <01121600323100.01820@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 December 2001 15:59, Mike Galbraith wrote:
> > > > I have a slackware initrd (minix) which is booting fine with 2.4.10
> > > > but fails to boot with 2.4.12 and later (same .config, same
> > > > bootloader, same hardware, same AC voltage in the wall outlet, time
> > > > of day differs by 1 minute), so it might be true :-)
> > >
> > > Hmm.. works here with 2.5.1-pre8.
> > >
> > > 	-Mike
> > > ...
> > > RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
> > > ...
> > > RAMDISK: Compressed image found at block 0
> > > Freeing initrd memory: 5161k freed
> > > MINIX-fs: mounting unchecked file system, running fsck is recommended.
> > > VFS: Mounted root (minix filesystem).
> > > Freeing unused kernel memory: 236k freed
> >
> > I'd like to try it, can you send a .config?
>
> .config?.. normal config with initrd+ramdisk+minix in kernel.

Yes. I want to take .config file from your kernel tree
for testing.

> > Have you tried it with minix initrd from
> >
> > http://port.imtp.ilyichevsk.odessa.ua/linux/vda/minix.gz
>
> No, I converted my 'fire department' initrd to minix and booted that.

I'll compile 2.5.1-pre8 here and try to boot my initrd.
If it boots ok, it would mean there is no problem with kernel
(i.e. my fault), if it won't, that will imply that _some_ minix initrds
are affected. Hope you got the idea...

BTW, is it possible for you to place your initrd on some publicly accessible 
ftp/http server?
--
vda
