Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbUBDBmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUBDBmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:42:10 -0500
Received: from dp.samba.org ([66.70.73.150]:58512 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266123AbUBDBmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:42:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools/udev and module auto-loading 
In-reply-to: Your message of "Tue, 03 Feb 2004 19:48:06 +0200."
             <1075830486.7473.32.camel@nosferatu.lan> 
Date: Wed, 04 Feb 2004 12:22:31 +1100
Message-Id: <20040204014222.46AF02C29B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1075830486.7473.32.camel@nosferatu.lan> you write:
> > I think it's an excellent idea, although ideally we would have this
> > mechanism in userspace as much as possible.  Anything from some
> > special hack to block -ENOENT on directory lookups and notify an fd,
> > to some exotic overlay filesystem.
> 
> Something like attached.  Besides me not knowing if there is a better
> place for it, it have the following issues:

Dude, you're brave.  I mean, really, really brave.

However, it strikes me that the automounter does similar tricks, and
so a similar setup should be possible for /dev.

Al?  Suggestions appreciated?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
