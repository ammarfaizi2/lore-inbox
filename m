Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131788AbQKAXFM>; Wed, 1 Nov 2000 18:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbQKAXFB>; Wed, 1 Nov 2000 18:05:01 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:4737 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S131788AbQKAXEo>; Wed, 1 Nov 2000 18:04:44 -0500
Date: Wed, 1 Nov 2000 18:04:38 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: Kurt Garloff <garloff@suse.de>
cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <20001101235734.D10585@garloff.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.21.0011011802500.14734-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Kurt Garloff wrote:

>On Wed, Nov 01, 2000 at 11:40:58PM +0100, J . A . Magallon wrote:
>> I have noticed that in latest patch for 2.4.0, the global Makefile
>> no more tries to find a kgcc, and falls back to gcc.
>> I suppose because 2.7.2.3 is no more good for kernel, but still you
>> can use 2.91, 2.95.2 or 2.96(??). Is that a patch that leaked in
>> the way to test10, or is for another reason ?.
>
>kgcc is a redhat'ism. They invented this package because their 2.96 fails
>compiling a stable kernel. However, it's not a good idea to dist specific
>code into the official kernel tree.

Big picture.

It may be distribution specific right now, but that doesn't stop other
distributions from needing it later.

-- 
-George Greer

(It's not like it's "redhat-gcc", which would qualify as specific.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
