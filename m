Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSK2DyA>; Thu, 28 Nov 2002 22:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbSK2DyA>; Thu, 28 Nov 2002 22:54:00 -0500
Received: from dp.samba.org ([66.70.73.150]:48265 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266952AbSK2Dx5>;
	Thu, 28 Nov 2002 22:53:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and table support 
In-reply-to: Your message of "Thu, 28 Nov 2002 14:01:50 -0800."
             <3DE6924E.9060609@pacbell.net> 
Date: Fri, 29 Nov 2002 14:26:44 +1100
Message-Id: <20021129040120.5F0B72C239@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DE6924E.9060609@pacbell.net> you write:
> This is a multi-part message in MIME format.
> 
> --Boundary_(ID_oTV6oYegTuXHnGSwqC+1Lw)
> Content-type: text/plain; charset=us-ascii; format=flowed
> Content-transfer-encoding: 7BIT
> 
> 
> > Hmm, with 2.5.50 and module-init-tools 0.8a two "modules.*map" files
> > are created -- but they're empty.  That's with the latest 2.5 modutils
> > 
> >   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> > 
> > So that's not quite working yet. ...
> 
> OK -- good news!
> 
> I now have USB hotplugging behaving again, with three patches on
> top of 2.5.50 and modutils 0.8a :
> 
> - The <linux/module.h> patch included with your 0.8a announce:
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=103845080926386&w=2
> 
> - A tweak to that patch to still include <linux/elf.h> (to compile)

Good!  I think I'll release a 2.5.50 modules megapatch while I'm
waiting for Linus to merge.

> - The attached patch to your "modprobe", implementing "-n" and (so
>    I can see it works at least partially) using "-v".

And the compulsory spelling fix (Adam put that in, I'm sure it was to
check that people were paying attention).

Thanks, merged for 0.9 with the globals changed to locals and the
"wrong arg" fprintf removed (getopt prints a message) rather than
fixed.

Thanks very much for the testing and the patch!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
