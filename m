Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbVHTAeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVHTAeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVHTAet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:34:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54013 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965202AbVHTAet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:34:49 -0400
Subject: Re: lost ticks and Hangcheck
From: john stultz <johnstul@us.ibm.com>
To: Nathan Becker <nbecker@physics.ucsb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508191714150.8252@claven.physics.ucsb.edu>
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
	 <20050819094500.GB16279@kurtwerks.com>
	 <Pine.LNX.4.63.0508191714150.8252@claven.physics.ucsb.edu>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 17:34:43 -0700
Message-Id: <1124498084.2932.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 17:22 -0700, Nathan Becker wrote:
> > I use the no_timer_check kernel parm and that keeps the clock from
> > running at double speed. I still see some other annoying boot-time
> 
> As I mentioned, no_timer_check doesn't fix it for me.  In fact it makes 
> the problem significantly worse.  I tried it again just to be sure.  Also 
> I tried noapic again and it doesn't help either.
> 
> I found there was an upgrade to the NVIDIA graphics driver that addressed 
> a clock issue (I don't know if it's related to my problem).  I upgraded 
> from version 7667 to 7676.  That seemed to help a little bit, at least in 
> prolonging the amount of time I could reasonably use the system.  Someone 
> in another thread mentioned that they thought this problem might be caused 
> by something in x.org, which I am using.

Please make sure this issue is reproducible without any binary only
drivers.

> Any other ideas or patches would be much appreciated.


If it happens w/o binary only drivers, could you open a bug at
bugzilla.kernel.org and provide full dmesg output?

Also check bug #3341 to see if it is at all similar to what you are
seeing.

thanks
-john


