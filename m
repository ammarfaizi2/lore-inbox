Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSK1XiR>; Thu, 28 Nov 2002 18:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSK1XiQ>; Thu, 28 Nov 2002 18:38:16 -0500
Received: from dp.samba.org ([66.70.73.150]:19869 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266841AbSK1XiP>;
	Thu, 28 Nov 2002 18:38:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support 
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
In-reply-to: Your message of "Wed, 27 Nov 2002 14:59:31 -0800."
             <3DE54E53.8000005@pacbell.net> 
Date: Fri, 29 Nov 2002 10:39:05 +1100
Message-Id: <20021128234536.B34522C0BA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DE54E53.8000005@pacbell.net> you write:
> Thanks, but I was hoping for a less radical solution:  just fixing
> the "no device table support" bug fixed in the latest modutils ... I
> do like the idea of forward motion in the module support, except that's
> not what we've seen so far with modutils.

Um, device table support went back in .49, at Adam's request (grand
plans are great and all that, but other maintainers are busy too, and
it'll take a while to get the new scheme sorted out).  You just have to
run depmod -a to generate the .xxxmap files.

The patch included in the 0.8 NEWS file allows the new depmod to
generate the tables too.

> Seems like one of the issues is that there's really no maintainer
> for modutils lately.  And I'm not even sure where to get the latest
> modutils (more recent than 0.7) even if I were ready to patch them.

Sorry, I thought I posted it a fair bit.
	http://www.[COUNTRY].kernel.org/pub/linux/kernel/people/rusty/modules

Hope that helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
