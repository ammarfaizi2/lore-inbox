Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSLPVc1>; Mon, 16 Dec 2002 16:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLPVc0>; Mon, 16 Dec 2002 16:32:26 -0500
Received: from dp.samba.org ([66.70.73.150]:43189 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261593AbSLPVc0>;
	Mon, 16 Dec 2002 16:32:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: vamsi@in.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
In-reply-to: Your message of "Mon, 16 Dec 2002 16:36:34 +0530."
             <20021216163634.A29099@in.ibm.com> 
Date: Tue, 17 Dec 2002 08:36:10 +1100
Message-Id: <20021216214023.624E32C27B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021216163634.A29099@in.ibm.com> you write:
> Hi Rusty,
> 
> It seems we cannot unload modules if they have a '-' in their name. 
> filename2modname() in rmmod.c converts a '-' in the filename
> to '_'. Why? Are dashes not allowed as part of module names?

How did you get a module which has - in its name?  The build system
*should* turn them into _'s.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
