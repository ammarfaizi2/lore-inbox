Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262571AbRENX3r>; Mon, 14 May 2001 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262572AbRENX3h>; Mon, 14 May 2001 19:29:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65228 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262571AbRENX30>;
	Mon, 14 May 2001 19:29:26 -0400
Date: Mon, 14 May 2001 19:29:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zRIW-0001dr-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105141925220.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Alan Cox wrote:

> > Oh, _that_ one. <shrug> pass rootname=driver!name (or whatever syntax
> > you prefer) to the kernel and call do_mount() instead of sys_mknod() in
> > prepare_namespace() (rootfs patch). BFD.
> 
> Yet another 2.5 project. If Linus wants to go play with name driven devices
> and you want to help him great, but if he'd care to put out
> linux-2.5.0.tar.gz _before_ starting that would be good for all of us

Frankly, I'd love to see 2.4.5-pre2 before June ;-)

BTW, rootfs is backwards-compatible - all setups that used to work still
do. And yes, it includes devfs/nfs-root/initrd without linuxrc/initrd
with linuxrc that terminates/initrd with linuxrc that execs init/loading
ramdisk from floppies, etc. Testing was a bitch ;-/

