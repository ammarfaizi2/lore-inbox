Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVCAUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVCAUjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVCAUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:38:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35806 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261648AbVCAUfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:35:33 -0500
Subject: Re: Network speed Linux-2.6.10
From: Lee Revell <rlrevell@joe-job.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-os@analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4224D0F5.4050400@candelatech.com>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
	 <4224CE98.2060204@candelatech.com> <1109708691.14272.8.camel@mindpipe>
	 <4224D0F5.4050400@candelatech.com>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 15:35:31 -0500
Message-Id: <1109709331.17405.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 12:30 -0800, Ben Greear wrote:
> Lee Revell wrote:
> > On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
> > 
> >>What happens if you just don't muck with the NIC and let it auto-negotiate
> >>on it's own?
> > 
> > 
> > This can be asking for trouble too (auto negotiation is often buggy).
> > What if you hard set them both to 100/full?
> 
> I have not noticed any buggy autonegotiation with the e100 driver in several
> years...
> 

Sorry, I misread the post.  He tried this.

I was under the impression this was due to inconsistent implementation
of autonegotiation in hardware.  When I was an ISP sysadmin we had this
problem with various devices (Cisco switches, Linux and BSD/OS
machines).  A device would get power cycled and one side would come up
100/full, the other 100/half.   We ended up hard setting everything.

Lee

