Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269810AbTGKGys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269811AbTGKGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 02:54:48 -0400
Received: from AMarseille-201-1-5-121.w217-128.abo.wanadoo.fr ([217.128.250.121]:62503
	"EHLO gaston") by vger.kernel.org with ESMTP id S269810AbTGKGyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 02:54:46 -0400
Subject: Re: Linux 2.5.75
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057907355.505.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 09:09:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 23:14, Linus Torvalds wrote:
> Ok. This is it. We (Andrew and me) are going to start a "pre-2.6" series,
> where getting patches in is going to be a lot harder. This is the last
> 2.5.x kernel, so take note.
> 
> The probably most notable thing here is the anticipatory scheduler,
> which has been in -mm for a long time, and was the major piece that
> hadn't been merged. 
> 
> Some architecture updates: cris has been updated for 2.5, ia64 and arm26 
> updates etc.  And various random (smallish) things.

Hi Linus !

I'm quite concerned about Power Management. Patrick haven't yet merged
the new implementation which changes the driver-side semantics to
something sane and your above mail seem to imply this is now too late.

While I agree these should have been merged a lot earlier, I'm also
annoyed by the fact that the existing save_state/suspend semantics
are just plain broken...

What do you plan on this regard ? Patrick, do you still need to hold
your patch until OLS ? They should get in now, that won't prevent
you from doing your paper ;)

Ben.

