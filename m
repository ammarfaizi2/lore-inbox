Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbSLLXAs>; Thu, 12 Dec 2002 18:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbSLLXAs>; Thu, 12 Dec 2002 18:00:48 -0500
Received: from dp.samba.org ([66.70.73.150]:7627 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267558AbSLLXAr>;
	Thu, 12 Dec 2002 18:00:47 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: linux-kernel@vger.kernel.org, wz6b@arrl.net
Subject: Re: 2.5.50 Up and running but 
In-reply-to: Your message of "Thu, 12 Dec 2002 01:21:01 MDT."
             <20021212012101.238ae459.arashi@arashi.yi.org> 
Date: Fri, 13 Dec 2002 09:20:04 +1100
Message-Id: <20021212230836.B5D2D2C07C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021212012101.238ae459.arashi@arashi.yi.org> you write:
> On Wed, 11 Dec 2002 22:59:10 -0800
> Matt Young <wz6b@arrl.net> wrote:
> 
> > Boot couldn't find the module dependency file, even though I did make modul
es 
> > and make modules_install
> 
> Yeah, the make rule for depmod got removed in one of the module merges. This
> will put it back. (Untested, my init scripts run depmod so it's not a big dea
l
> for me.) Rusty, am I being stupid or is this okay now that depmod
> works?

Yep, that's fine: the original modprobe replacement didn't need
modules.dep, but Adam Richter has 1300 modules and he complained about
the speed (and provided the patch to modprobe to use modules.dep, so
what could I say?)

Hopefully when Linus comes back he'll take my patches,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
