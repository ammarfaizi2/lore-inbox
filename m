Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbUKYCkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUKYCkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbUKYCkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:40:15 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:11206 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262918AbUKYCjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:39:01 -0500
Subject: Re: Clocks stopped drifting!  What happaned?
From: john stultz <johnstul@us.ibm.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41A4E37C.7060501@techsource.com>
References: <41A4E37C.7060501@techsource.com>
Content-Type: text/plain
Message-Id: <1101344573.31116.1.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 24 Nov 2004 17:02:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 11:39, Timothy Miller wrote:
> It used to be that on every computer where I was using Linux, the clocks 
> would drift really badly.  After a few weeks, they'd all be fast by as 
> much as 30 minutes, and it got to be annoying to have to periodically 
> reset the time.  For instance, this was the case for both a Dell with a 
> 1.8GHz Pentium 4 and for a home-built PC with an Athlon XP 2800+ (via 
> KT400 chipset).
> 
> I just realized that since I upgraded to 2.6.9, that problem has gone 
> away.  I'm not using NTP, but my clocks are suddenly reliable.
> 
> What happened?

I'd be interested if you could narrow down the release where you saw the
change. ie: Does 2.6.8.1 have the problem, or 2.6.7? 

My suspicion is the ACPI irq routing changes might have fixed it.

thanks
-john


