Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVL3ECv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVL3ECv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 23:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVL3ECv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 23:02:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29652 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750959AbVL3ECu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 23:02:50 -0500
Date: Thu, 29 Dec 2005 23:02:35 -0500
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230040235.GE20371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <43B4ADD0.4040906@rtr.ca> <43B4B034.20807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B4B034.20807@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 10:57:40PM -0500, Mark Lord wrote:
 > Mark Lord wrote:
 > >
 > >Okay, I'm complaining:  /proc/cpuinfo is no longer correct
 > >for my Pentium-M notebook, as ov 2.6.15-rc7.  Now it reports
 > >a cpu speed of approx 800Mhz for a 2.0Mhz Pentium-M.
 > 
 > 2.0GHz, not Mhz!  (blush)
 > 
 > Prior to -rc7, /proc/cpuinfo would scale according to the
 > current speedstep of the CPU.  Now it seems stuck at the
 > lowest setting for some reason.

Ok, if the scaling doesn't work any more, that's a bug rather
than an intentional breakage.  More details please? dmesg ?
/sys/devices/system/cpu/cpufreq contents? What were you using
to do the scaling previously?  (An app, or ondemand)

		Dave

