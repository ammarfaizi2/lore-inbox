Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbULHS4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbULHS4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbULHS4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:56:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:8648 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261268AbULHS4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:56:02 -0500
Subject: Re: [RFC] New timeofday proposal (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0412081337150.3803@xanadu.home>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412081337150.3803@xanadu.home>
Content-Type: text/plain
Message-Id: <1102532227.1281.61.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 10:57:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 10:43, Nicolas Pitre wrote:
> On Tue, 7 Dec 2004, john stultz wrote:
> 
> > Points I'm glossing over for now:
> > ====================================================
> > 
> > o Some arches (arm, for example) do not have high res timing hardware
> 
> Just a note: The ARM architecture is rather a bunch of multiple 
> subarchitectures sharing the same instruction set but with wildly 
> different sets of peripherals.  Many of those ARM subarchitectures have 
> high res (sub microsec) timer capabilities.

Ah, I must have missed that when I looked over that code. I'll drop (or
at least qualify) the incorrect reference. 

Thanks for the correction!
-john


