Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKNElf>; Wed, 13 Nov 2002 23:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSKNElf>; Wed, 13 Nov 2002 23:41:35 -0500
Received: from dp.samba.org ([66.70.73.150]:9448 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261527AbSKNElf>;
	Wed, 13 Nov 2002 23:41:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters reimplementation 0/4 
In-reply-to: Your message of "Wed, 13 Nov 2002 23:16:52 CDT."
             <3DD323B4.6080404@pobox.com> 
Date: Thu, 14 Nov 2002 16:45:29 +1100
Message-Id: <20021114044828.8BBB32C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD323B4.6080404@pobox.com> you write:
> Rusty Russell wrote:
> 
> > Finally, if you do not use your own types, PARAM() can be #defined
> > into a MODULE_PARM statement for 2.4 kernels (ie. backwards
> > compatible).  Patch 4/4 also translates old-style MODULE_PARM() into
> > PARAMs at load time, for existing modules.
> 
> Let's be more friendly to the namespace and call it something less 
> ambiguous, like MODULE_PARAM, even if that might not be strictly true in 
> 1% of the cases.  IMO there are certainly valid local uses of 'PARAM' in 
> kernel code.

I disagree.  It's a param, subsuming both __setup and MODULE_PARAM.
The fact that it is implemented for modules is not something for the
driver author to be concerned about (finally).

IMHO, fundamental elements deserve fundamental names.

> You can see from the totally gratuitous patch to 
> include/asm-i386/setup.h which should have been a clue...

>From which I am confident that noone else in i386, at least, uses it 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
