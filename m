Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312886AbSDOPjQ>; Mon, 15 Apr 2002 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312872AbSDOPjP>; Mon, 15 Apr 2002 11:39:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50119 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312871AbSDOPjO>;
	Mon, 15 Apr 2002 11:39:14 -0400
Date: Mon, 15 Apr 2002 11:39:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Black <mblack@csihq.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 minix compile problem
In-Reply-To: <032301c1e491$1da99b50$e1de11cc@csihq.com>
Message-ID: <Pine.GSO.4.21.0204151138530.4334-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Apr 2002, Mike Black wrote:

> Patched my 2.5.7 tree with 2.5.8:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.7/include -Wall -Wstrict-prototypes -W
> no-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
>  -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -DKBUILD_B
> ASENAME=version -c -o init/version.o init/version.c
> make: *** No rule to make target
> `/usr/src/linux-2.5.7/include/linux/minix_fs_i.h', needed by
> `/usr/src/linux-2.5.7/include/linux/minix_fs.h'.  Stop.

make dep

