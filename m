Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUDOKhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDOKhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:37:14 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:8064 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S261779AbUDOKhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:37:13 -0400
Date: Thu, 15 Apr 2004 13:37:11 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: john stultz <johnstul@us.ibm.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
Message-ID: <20040415103711.GA320@elektroni.ee.tut.fi>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	george anzinger <george@mvista.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	David Ford <david+powerix@blue-labs.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <403CCD3A.7080200@mvista.com> <1077725042.8084.482.camel@cube> <403D0F63.3050101@mvista.com> <1077760348.2857.129.camel@cog.beaverton.ibm.com> <403E7BEE.9040203@mvista.com> <1077837016.2857.171.camel@cog.beaverton.ibm.com> <403E8D5B.9040707@mvista.com> <1081895880.4705.57.camel@cog.beaverton.ibm.com> <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de> <1081967295.4705.96.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081967295.4705.96.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 11:28:15AM -0700, john stultz wrote:
> On Wed, 2004-04-14 at 05:10, Tim Schmielau wrote:
> > Excuse me for barging in lately and innocently, but I find this patch
> > hard to comprehend:
> >  - shouldn't a foo_to_clock_t() function return a clock?
> >  - the x = seems superfluous
> >  - the #if is not a shortcut anymore, so why keep it?
> > Shouldn't this patch be more like the following
> > (completely untested)?
> 
> Yes, you're cleanups look much better! Although we still have yet to
> hear if it resolves the problem. 

Hi,
 
If we are still talking about the problem with ps showing process start 
times in future, I'm sorry neither of the patches helped. The error grows
here at a rate of 15 seconds in 24 hours as before.

-Petri
