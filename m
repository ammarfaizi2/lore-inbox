Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSFPSmB>; Sun, 16 Jun 2002 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFPSmA>; Sun, 16 Jun 2002 14:42:00 -0400
Received: from fungus.teststation.com ([212.32.186.211]:59922 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316503AbSFPSl7>; Sun, 16 Jun 2002 14:41:59 -0400
Date: Sun, 16 Jun 2002 20:40:39 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Linus Torvalds <torvalds@transmeta.com>
cc: Erik McKee <camhanaich99@yahoo.com>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [ERROR][PATCH] smbfs compilation in 2.5.21
In-Reply-To: <Pine.LNX.4.44.0206161122140.3316-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206162032550.6294-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002, Linus Torvalds wrote:

> Should not
> 
>   # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__ , ##  a)
> 
> work? Notice the one added extra space between __FUNCTION__ and ",".

That's what the gcc manual says.

There was a separate mail where I dropped some people I figured didn't
care too much about smbfs debug macros from the Cc list.

I will get back to you when someone with 2.95.x has verified it - or if
you know that it is supposed to work just change it. It's in use in
other places in the kernel tree.

/Urban

