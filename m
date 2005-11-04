Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVKDNvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVKDNvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVKDNvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:51:44 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:27322 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750842AbVKDNvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:51:43 -0500
Date: Fri, 4 Nov 2005 08:51:41 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: "Brown, Len" <len.brown@intel.com>, Jean-Christian de Rivaz <jc@eclis.ch>,
       macro@linux-mips.org, linux-kernel@vger.kernel.org, dean@arctic.org,
       zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
Message-ID: <20051104135141.GZ9486@csclub.uwaterloo.ca>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005117C9B@hdsmsx401.amr.corp.intel.com> <1131077233.27168.627.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131077233.27168.627.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 08:07:13PM -0800, john stultz wrote:
> Thanks for the info, Len. Although its odd that the Jean-Christian's
> issue appears to show up around the time the fix you mention shows up. 
> 
> Regardless, Jean-Chistian has some sever BIOS problems, so until those
> are resolved, I suggest he use the workaround (noapic) and ping us if
> the issue persists once he arrives at a supportable configuration.

Well as an update, running 2.6.14 in the last 17 hours, my system gained
26 minutes.  That seems to average gaining 1s every 44s.  So while
better than 2.6.12 by a lot, there is certainly still something odd with
the nforce2 handling.

I think I need to go grab that python script and run it to see how it is
gaining since it doesn't really appear to be at a constant rate.

Maybe I should check if my bios is the latest version.

And I could try with the apic override options.

I will try a few more things to see what is happening.

Len Sorensen
