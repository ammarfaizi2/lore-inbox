Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbSKOXLo>; Fri, 15 Nov 2002 18:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbSKOXLo>; Fri, 15 Nov 2002 18:11:44 -0500
Received: from dp.samba.org ([66.70.73.150]:29607 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266929AbSKOXLn>;
	Fri, 15 Nov 2002 18:11:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 2/4 
In-reply-to: Your message of "Fri, 15 Nov 2002 17:51:48 CDT."
             <3DD57A84.2070805@pobox.com> 
Date: Sat, 16 Nov 2002 10:17:37 +1100
Message-Id: <20021115231840.2FE3D2C09A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD57A84.2070805@pobox.com> you write:
> 1) I note you ignored Matthew Wilcox's example of module_init being used 
> in two different ways.

I didn't see it, sorry.  Valid point.

> 2) "proper", converted-to-Rusty-style driver code is going to have
> 
> 	MODULE_blah
> 	MODULE_foo
> 	MODULE_bar
> 	PARAM
> 
> You think that looks good??

Hmm... OK, you've swayed me.  I'll redo the patch.

> PARAM is ugly in drivers, and way too generic.

Well, we completely disagree on this point.  If I was starting from
scratch, MODULE_AUTHOR would simply be AUTHOR(), etc.

But I've always opposed this kind of "neatening" as the ultimite in
stupidity, so consistency wins.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
