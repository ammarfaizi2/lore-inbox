Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUA1A54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUA1A54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:57:56 -0500
Received: from dp.samba.org ([66.70.73.150]:51373 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265681AbUA1A5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:57:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core 
In-reply-to: Your message of "Tue, 27 Jan 2004 14:56:06 BST."
             <Pine.LNX.4.58.0401271142510.7855@serv> 
Date: Wed, 28 Jan 2004 10:29:23 +1100
Message-Id: <20040128005801.5B1A92C12C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0401271142510.7855@serv> you write:
> Hi,

Hi Roman!

> Fixing this requires changing every single module, but in the end it
> would be worth it, as it avoids the duplicated protection and we had
> decent module unload semantics.

And I still disagree. <shrug>

If it's any consolation, I don't plan any significant module work in
2.7.  If you want to work on this, you're welcome to it.  Perhaps you
can convince Linus et al that it's worth the pain?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
