Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTILV2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbTILV2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:28:12 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:56131 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id S261488AbTILV2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:28:07 -0400
Date: Fri, 12 Sep 2003 14:47:32 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Timothy Miller <miller@techsource.com>
cc: David Schwartz <davids@webmaster.com>,
       Pascal Schmidt <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <3F62335B.9050202@techsource.com>
Message-ID: <Pine.LNX.4.44.0309121428200.8729-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Timothy Miller wrote:
|>David Schwartz wrote:
|>
|>> 	However, some people seem to be arguing that the GPL_ONLY symbols are in
|>> fact a license enforcement technique. If that's true, then when they
|>> distribute their code, they are putting additional restrictions not in the
|>> GPL on it. That is a GPL violation.
|>
|>Agreed.  GPL_ONLY is not a license restriction.  It is a technical issue.
|>
|>Binary-only modules are inherently untrustworthy (no open code review) 
|>and undebuggable.  It is therefore of technical merit to restrict both 
|>what they can access in the kernel (GPL_ONLY) and limit how much kernel 
|>developers should have to tolerate when they're involved.
|>
|>But beyond this, there are some social issues.  If someone finds a way 
|>to work around this mechanism, they are breaking things to everyone 
|>else's detriment.  For a commercial entity to violate the GPL_ONLY 
|>barrier is an insult to kernel developers AND to their customers who 
|>will have trouble getting problems solved.

I think you are all missing the point.  This isn't a Linux kernel
problem.  This is a customer and distributor problem.  If Red Hat,
Mandrake, SuSE, etc., choose to remove these GPL_ONLY() barriers
and release the new "free" code under GPL, they're entitled.  Heck,
they can even add in new ones in their own kernels.

I'm surprised you are even discussing this issue on this list.

If third party developers are restricted based on GPL_ONLY(),
they can either (A) release their product under other OSes or Linux
distributions without the GPL_ONLY() restrictions, (B) modify their
product to be more GPL-friendly, or (C) avoid Linux support entirely.

It ultimately means either more support for third party products with
one distribution over another, which may or may not be financially
beneficial to that distribution, or it means that some Linux
distributors continue to supress supporting new third party devices
that don't believe in the GPL.  Either way, it's a distribution
decision based on open-source beliefs and how that balances with
financial benefit (both of which would matter to me as a stockholder).

This really has nothing to do with the Linux kernel code itself.
Very few customers that want third party device support will go to
vger to roll their own kernel -- they'll go to a Linux distributor,
get them to include device support and pay for it (or start with a
Linux distribution and roll their own).

So include GPL_ONLY(), don't include GPL_ONLY(), whatever.  If you
don't like it, Mr. Customer, find a Linux distributor that will
fix the problem for you.

If you want to create a new driver model that supports third party
devices without regard to their GPL status, make a patch.  Who
knows, maybe some distribution will actually start using it.  But
don't even think about bugging this list to get it included by
default (too many GPL purists out there).

--Matt

