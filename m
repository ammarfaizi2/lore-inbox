Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSK1EFR>; Wed, 27 Nov 2002 23:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSK1EET>; Wed, 27 Nov 2002 23:04:19 -0500
Received: from dp.samba.org ([66.70.73.150]:984 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265140AbSK1EEP>;
	Wed, 27 Nov 2002 23:04:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and table support 
In-reply-to: Your message of "Wed, 27 Nov 2002 13:53:58 -0800."
             <3DE53EF6.4080303@pacbell.net> 
Date: Thu, 28 Nov 2002 14:14:29 +1100
Message-Id: <20021128041136.35CA02C081@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DE53EF6.4080303@pacbell.net> you write:
> One of the points being that the breakage comes from changing the
> format supported by modutils.  Restoring current functionality should
> IMO be high on the agenda .... USB has worked poorly in normal .configs
> for a while now, because of this.

Absolutely.  I sent the patch to put the USB etc. tables back in
(merged in .48 IIRC).

Hopefully this is back together: the device-table-to-aliases stuff is
a separate step which can be argued on its own, and I think will
probably have to wait for 2.7 unless Greg is going to champion it.

The real win is simplicity and independence from the kernel
datastructures (which probably won't change during 2.6 anyway).

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
