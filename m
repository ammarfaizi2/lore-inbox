Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289575AbSAONf2>; Tue, 15 Jan 2002 08:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289549AbSAONfS>; Tue, 15 Jan 2002 08:35:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60544 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289576AbSAONfJ>; Tue, 15 Jan 2002 08:35:09 -0500
Date: Tue, 15 Jan 2002 08:36:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: initrd failure on Linux-2.4.17
In-Reply-To: <Pine.LNX.4.43.0201150846320.29728-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.3.95.1020115083434.8305A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Jeff Chua wrote:

> On Mon, 14 Jan 2002, Richard B. Johnson wrote:
> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 581k freed
> > kernel panic: VFS: Unable to mount root fs on 01:00
> >
> > Has somebody fixed this or is it expected that nobody uses
> > an initial RAM disk on 2.4.17 ..or.. is this not the latest
> > "stable" version of Linux to use?
> 
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 5384k freed
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 172k freed
> 
> I booted with Linux-2.4.0 up to 2.4.18-pre3.
> 
> Did you specify root=/dev/hda2 in your boot file?
> 

No. Root is initially /dev/ram0, and will pivot-root to
/dev/scd1 once it works. The initial ram-disk, /dev/ram0
is never mounted so that's as far as it gets.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


