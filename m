Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282489AbRLOMLT>; Sat, 15 Dec 2001 07:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282497AbRLOMLK>; Sat, 15 Dec 2001 07:11:10 -0500
Received: from www.wen-online.de ([212.223.88.39]:14355 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S282489AbRLOMLF>;
	Sat, 15 Dec 2001 07:11:05 -0500
Date: Sat, 15 Dec 2001 13:14:49 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Alexander Viro <viro@math.psu.edu>, Joy Almacen <joy@empexis.com>,
        <wa@almesberger.net>, <linux-kernel@vger.kernel.org>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: pivot_root and initrd kernel panic woes
In-Reply-To: <01121311222003.01849@manta>
Message-ID: <Pine.LNX.4.33.0112151238450.306-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, vda wrote:

> On Thursday 13 December 2001 06:19, Alexander Viro wrote:
> > On Thu, 13 Dec 2001, vda wrote:
> > > BTW, don't go for 2.4x, x>10. initrd is broken there and is still
> > > unfixed.
> >
> > Bullshit.
>
> I have a slackware initrd (minix) which is booting fine with 2.4.10
> but fails to boot with 2.4.12 and later (same .config, same bootloader,
> same hardware, same AC voltage in the wall outlet, time of day differs by
> 1 minute), so it might be true :-)

Hmm.. works here with 2.5.1-pre8.

	-Mike
...
RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
...
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 5161k freed
MINIX-fs: mounting unchecked file system, running fsck is recommended.
VFS: Mounted root (minix filesystem).
Freeing unused kernel memory: 236k freed

