Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSLaXNf>; Tue, 31 Dec 2002 18:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSLaXNe>; Tue, 31 Dec 2002 18:13:34 -0500
Received: from dp.samba.org ([66.70.73.150]:51124 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264853AbSLaXNe>;
	Tue, 31 Dec 2002 18:13:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Marcus Alanen <maalanen@ra.abo.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] opti92x-ad1848 one check_region fixup 
In-reply-to: Your message of "Mon, 30 Dec 2002 22:28:24 +0200."
             <Pine.LNX.4.44.0212302222530.30703-100000@tuxedo.abo.fi> 
Date: Wed, 01 Jan 2003 10:17:59 +1100
Message-Id: <20021231232200.DDA802C290@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0212302222530.30703-100000@tuxedo.abo.fi> you write:
> Initializes the variables (the chip->xxx stuff) before calling 
> anything else. snd_legacy_find_free_ioport() uses request_region now, 
> so remember to release regions in the private freeing routine 
> snd_card_opti9xx_free().

The patch looks good, but the Trivial Patch Monkey (ook ook!) doesn't
handle chains of patches which depend on each other 8(

So I've only grabbed the first one...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
