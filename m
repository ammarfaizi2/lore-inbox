Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbRGaDJe>; Mon, 30 Jul 2001 23:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269167AbRGaDJY>; Mon, 30 Jul 2001 23:09:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64722 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269158AbRGaDJL>;
	Mon, 30 Jul 2001 23:09:11 -0400
Date: Mon, 30 Jul 2001 23:09:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch 
In-Reply-To: <31687.996542498@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0107302259280.19391-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 31 Jul 2001, Keith Owens wrote:

> On Mon, 30 Jul 2001 17:56:25 -0500 (CDT), 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Eventually I would like to see firmware uploading in initramfs,
> >instead of compiling firmware images into the kernel...
> 
> <AOL>Me too</AOL>.  Building the firmware images as part of kbuild is
> wrong, they should be in separate user space packages.  One of my
> biggest problems with kbuild 2.5 was supporting the firmware build for
> sound and SCSI cards in the kernel, it is all ugly special case code.

<shrug> Once the late-boot stuff is stable - why not? It's clearly
separate patch and I suspect that the trickiest part will be
to come up with a reasonable way of telling make process what to
put into the archive.

