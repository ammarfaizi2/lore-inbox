Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSKZB0Q>; Mon, 25 Nov 2002 20:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKZB0Q>; Mon, 25 Nov 2002 20:26:16 -0500
Received: from dp.samba.org ([66.70.73.150]:5557 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265978AbSKZB0O>;
	Mon, 25 Nov 2002 20:26:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@freya.yggdrasil.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep 
In-reply-to: Your message of "Mon, 25 Nov 2002 14:54:42 -0800."
             <200211252254.OAA04288@freya.yggdrasil.com> 
Date: Tue, 26 Nov 2002 11:45:10 +1100
Message-Id: <20021126013330.8DC822C31D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211252254.OAA04288@freya.yggdrasil.com> you write:
> Rusty Russell wrote:
> >(you took out module alias support in your patch, though) 8(.
> 
> 	Did not.  See the routine get_alias() in my version.

No, you took out the part that reads the aliases from the module
itself (.modalias section).

> 	However, my version does not support:
> 
> 		 wildcard aliases,
> 		 an alias that expands to multiple targets, or
> 		 an alias that expands to an alias.
> 
> 	It should only take a few lines to fix the first two.

See my wishlist for the second one (or/and support): this is a request
I got from someone.

> As for last, I'm not sure how useful aliasing to an alias really is.

Don't know.  Combinations of and/or aliases would be easiest with
this, though.

> It wouldn't be the Manhattan Project to add it, but I'd rather not
> add a feature if it has no real use.

Good man!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
