Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265799AbSKAWXw>; Fri, 1 Nov 2002 17:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265801AbSKAWXv>; Fri, 1 Nov 2002 17:23:51 -0500
Received: from dp.samba.org ([66.70.73.150]:28813 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265799AbSKAWXB>;
	Fri, 1 Nov 2002 17:23:01 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's left over. 
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-reply-to: Your message of "01 Nov 2002 13:30:18 -0000."
             <1036157418.12693.19.camel@irongate.swansea.linux.org.uk> 
Date: Sat, 02 Nov 2002 09:28:48 +1100
Message-Id: <20021101222930.964392C5B0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1036157418.12693.19.camel@irongate.swansea.linux.org.uk> you write:
> On Thu, 2002-10-31 at 21:02, Jeff Garzik wrote:
> > hosed/screaming, and various mid-layers are dying.  For LKCD to be of 
> > any use, it needs to _skip_ the block layer and talk directly to 
> > low-level drivers.
> 
> Rusty wrote a polled IDE driver that should handle some subset of that

Yes, patch has bitrotted but updating should be trivial.  There's
enough there that you get the idea though: frankly, it's noninvasive
enough for entry during the 2.6.x series, so it's been down on my
list:

	http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/oopser.patch.gz

I'd love someone to take this for a spin and tweak it up...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
