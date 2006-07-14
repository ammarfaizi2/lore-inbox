Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWGNANB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWGNANB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWGNANB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 20:13:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161146AbWGNANA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 20:13:00 -0400
Date: Thu, 13 Jul 2006 20:12:54 -0400
From: Dave Jones <davej@redhat.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 18rc1 soft lockup
Message-ID: <20060714001253.GE10855@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	john stultz <johnstul@us.ibm.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060711190346.GK5362@redhat.com> <1152645227.760.9.camel@cog.beaverton.ibm.com> <20060711191658.GM5362@redhat.com> <20060713220722.GA3371@redhat.com> <1152828943.6845.107.camel@localhost> <Pine.LNX.4.64.0607140058400.12900@scrub.home> <1152835358.6845.119.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152835358.6845.119.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 05:02:38PM -0700, john stultz wrote:
 
 > > I don't quite understand how this is clock related, soft lockup uses 
 > > jiffies and there is nothing clock related in the trace???
 > 
 > Hmmm. Well, its easy to check:
 > 
 > Dave, could you comment out the "clocksource_adjust(...)" line in
 > kernel/timer.c::update_wall_time() just to check if its the same issue?

I'll try, but just like every other bug I've hit together, it's
non-deterministic.  I'll do a half dozen boots to see if turns up again.

Whatever happened to the good old days of reproducable bugs? :)

		Dave
-- 
http://www.codemonkey.org.uk
