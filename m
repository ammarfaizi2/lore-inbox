Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJYVkD>; Fri, 25 Oct 2002 17:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJYVkD>; Fri, 25 Oct 2002 17:40:03 -0400
Received: from main.gmane.org ([80.91.224.249]:44700 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261615AbSJYVkC>;
	Fri, 25 Oct 2002 17:40:02 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 7
Date: Fri, 25 Oct 2002 17:47:14 -0400
Message-ID: <apce14$n0o$1@main.gmane.org>
References: <3DB9A314.6CECA1AC@mvista.com>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035582309 23576 130.127.121.177 (25 Oct 2002 21:45:09 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Fri, 25 Oct 2002 21:45:09 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> 
> This patch, in conjunction with the "core" high-res-timers
> patch implements high resolution timers on the i386
> platforms.  The high-res-timers use the periodic interrupt
> to "remind" the system to look at the clock.  The clock
> should be relatively high resolution (1 micro second or
> better).  This patch allows configuring of three possible
> clocks, the TSC, the ACPI pm timer, or the Programmable
> interrupt timer (PIT).  Most of the changes in this patch
> are in the arch/i386/kernel/timer/* code.
> 
Any suggestions on making this patch "more friendly" with 2.5.44-ac3?  
Apparently some of his patch mucked around in the timers source files as 
well as defining completely opposite macros in 
arch/i386/kernel/timers/Makefile.  I might of missed it, but I didn't 
notice anything in his changelog which would jump out at me, except for 
some of the Cyrix fixes.  I'm going to give it a shot, but I thought I'd 
ask as well.

Cheers,
Nicholas


