Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVGMS4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVGMS4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVGMSyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:54:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262397AbVGMSxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:53:18 -0400
Date: Wed, 13 Jul 2005 11:53:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>
cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux v2.6.13-rc3
In-Reply-To: <200507131259.04855.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.58.0507131145310.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
 <200507131259.04855.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Len, ACPI people - can we fix this regression, please?

Rafael even pinpoints exactly which patches are causing the problem, so 
why didn't they get reverted before sending them off to me?

Grumble. I don't like being sent known-bad patches when we're trying to 
calm things down.

		Linus


On Wed, 13 Jul 2005, Rafael J. Wysocki wrote:
>
> Hi,
> 
> On Wednesday, 13 of July 2005 07:05, Linus Torvalds wrote:
> > 
> > Yes,
> >  it's _really_ -rc3 this time, never mind the confusion with the commit 
> > message last time (when the Makefile clearly said -rc2, but my over-eager 
> > fingers had typed in a commit message saying -rc3).
> > 
> > There's a bit more changes here than I would like, but I'm putting my foot 
> > down now. Not only are a lot of people going to be gone next week for LKS 
> > and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
> > down.
> 
> FYI, on my box (Asus L5D, Athlon 64 + nForce3, 64-bit kernel) there are two
> regressions wrt -rc2 related to ACPI.  First, the battery monitor does not work
> (http://bugzilla.kernel.org/show_bug.cgi?id=4665)
> and second, the box hangs solid during resume from disk if IO-APIC is not used
> (http://bugzilla.kernel.org/show_bug.cgi?id=4416).
> 
> The problems have been known for quite some time and remain unresolved,
> but apparently they have made it to mainline nevertheless.  I understand
> nobody else has reported them, but I also know of some people who run
> Linux on the same hardware and 2.6.13 will not work for them if these
> issues are present in it.
> 
> Greets,
> Rafael
> 
> 
> -- 
> - Would you tell me, please, which way I ought to go from here?
> - That depends a good deal on where you want to get to.
> 		-- Lewis Carroll "Alice's Adventures in Wonderland"
> 
