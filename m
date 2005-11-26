Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVKZVgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKZVgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKZVgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:36:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:24812 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750753AbVKZVgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:36:00 -0500
Date: Sat, 26 Nov 2005 22:35:58 +0100
From: Andi Kleen <ak@suse.de>
To: Olivier Fourdan <fourdan@xfce.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: x86_64: Test patch for ATI/Nvidia timer problems
Message-ID: <20051126213558.GE20775@brahms.suse.de>
References: <1133038416.6253.5.camel@shuttle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133038416.6253.5.camel@shuttle>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 09:53:36PM +0100, Olivier Fourdan wrote:
> Hi
> 
> > Everybody who saw timing problems with ATI IXP based boards with x86-64 
> > or some Nvidia NForce4 boards please test this patch. Please send 
> > success/failure to me.
> 
> I've applied the patch on a clean 2.6.15-rc2 source tree, built it, and rebooted with high hopes...
> 
> Unfortunately, it makes no difference here (HP/Compaq R3200 laptop, AMD64 3400+, nforce3).

It wasn't supposed to help on nforce3 anyways. But please send boot log and output
of http://www.firstfloor.org/~andi/ttime.c running for a few minutes and 
an exact description of what problems you're seeing.

-Andi
