Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVH3Nrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVH3Nrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVH3Nrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:47:47 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:55176 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750926AbVH3Nrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:47:46 -0400
Date: Tue, 30 Aug 2005 15:47:43 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Nathan Becker <nbecker@physics.ucsb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost ticks and Hangcheck
Message-ID: <20050830134743.GA26890@janus>
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 12:41:07AM -0700, Nathan Becker wrote:
> Hi,
> 
> I'm running kernel 2.6.12.5 with x86_64 target on an AMD X2 4800+ and 
> Gigabyte GA-K8NXP-SLI motherboard (bios version F8).  I'm having a problem 
> with lost clock ticks.  The dmesg says
> 
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> 
> Also if I enable hangcheck, then I get a huge number of Hangcheck messages 
> in dmesg.

I get a lot of "kernel: Hangcheck: hangcheck value past margin!" messages
from 2.6.13-rc7 on AMD64 X2 3800+ and Asus A8V deluxe motherboard. No lost
ticks messages however.

> 
> The main other symptom is that the system clock runs fast and 
> inaccurately.  It seems to run more inaccurately when I'm using the CPU, 
> and be basically OK when idling.

That seems to be the case here too: clock runs too fast under heavy load
(burn-in tests involving kernel builds and large disk copies).

-- 
Frank
