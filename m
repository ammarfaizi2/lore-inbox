Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUGVWaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUGVWaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267315AbUGVWaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:30:14 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4839 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267314AbUGVWaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:30:06 -0400
Date: Thu, 22 Jul 2004 15:28:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: akpm@osdl.org, corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-Id: <20040722152839.019a0ca0.pj@sgi.com>
In-Reply-To: <20040722193337.GE19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org>
	<20040721231123.13423.qmail@lwn.net>
	<20040721235228.GZ14733@fs.tum.de>
	<20040722025539.5d35c4cb.akpm@osdl.org>
	<20040722193337.GE19329@fs.tum.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's much worth in having a very stable kernel.

There certainly is.  But the contribution that having a separate 2.7/2.8
kernel at the head (Linus, et. al.) end has to a user having a stable kernel
is not what you think it is.

The direction presented to us now is having smaller, more continuous,
steps in the head end, over having fewer larger, more disruptive steps. 
Do we do all the incompatible changes in a big chunk, once every couple
of years, or do we do them one a week, ongoing.

Now, I repeat, this is at the head end.  End users who want stability
aren't feeding directly off kernel.org anyway.

The affect downstream on real users is this.  If the head end operates
in big chunky style, then as this big change flows downstream, it makes
transitions for distros, service providers and middlemen more costly and
difficult, creating expenses that must be passed on to the end user.

Yes - damming up the flow of changes creates stability.  But if you're a
middleman, you don't need Linus to choose where to build the dam, and
when to open the flood gates.  It's more efficient for you to choose for
yourself when to do that damming, based on your particular resources and
customer needs, rather than have to deal with hundred year floods and
draughts imposed on you by Zeus.

The end user always gets their stability, if only because they won't
upgrade a system that is "working".

And every change at the head end is disruptive for some poor slob.
The only perfectly compatible change is no change at all.  We delude
ourselves if we think we can separate the "safe" fixes and additions
from the "unsafe" incompatible changes.  Better that we should expend
some energy on smoothing out and minimizing the cost of change to those
downstream from us.  This needs to be done the old-fashioned way, one
change at a time.

The question is whether we impose, on all those downstream from us,
occasional hundred year floods, or do we provide a steady stream, and
let them build their own little beaver dams, as suits their various and
diverse needs and business cycles.

The great lesson of capitalism over communism is that a thousand free
workers and investors, each optimizing their own little plot or
portfolio, beats a single centrally imposed five year plan, even if the
man pulling the levers is a genius such as Linus or Lenin (sorry, Linus,
couldn't resist ...).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
