Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUA1CgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUA1CgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:36:19 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60937 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265791AbUA1CgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:36:18 -0500
Date: Wed, 28 Jan 2004 03:36:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core 
In-Reply-To: <20040128005801.5B1A92C12C@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0401280304180.7851@serv>
References: <20040128005801.5B1A92C12C@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

On Wed, 28 Jan 2004, Rusty Russell wrote:

> > Fixing this requires changing every single module, but in the end it
> > would be worth it, as it avoids the duplicated protection and we had
> > decent module unload semantics.
>
> And I still disagree. <shrug>

And I still don't know why. :(

> If it's any consolation, I don't plan any significant module work in
> 2.7.  If you want to work on this, you're welcome to it.  Perhaps you
> can convince Linus et al that it's worth the pain?

Well, the problem is that this won't be an one man show, it requires that
a number of kernel hackers understand the problem and the possible
solutions are discussed beforehand. I can understand that a lot here are
scared of such big change, but either we either continue complaining about
module unloading or we do something about it and this requires exploring
the various possibilities.
Rusty, you are the modules maintainer, you are supposed to understand
these issues, if you already block a discussion like that, what am I
supposed to expect from others? I really don't claim to have all the
answers and I really would like to discuss the various possible approaches
to solve this problem, so people also know what they can expect.

bye, Roman
