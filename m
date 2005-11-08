Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVKHW72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVKHW72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVKHW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:59:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:63199 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030387AbVKHW72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:59:28 -0500
Subject: Re: athlon x2 + 2.6.14 + SMP = fast clock
From: john stultz <johnstul@us.ibm.com>
To: Christopher Mulcahy <cmulcahy@avesi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131498162.21752.102.camel@jones>
References: <1131482417.21752.50.camel@jones>
	 <1131485903.27168.662.camel@cog.beaverton.ibm.com>
	 <1131498162.21752.102.camel@jones>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 14:59:25 -0800
Message-Id: <1131490766.27168.669.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 20:02 -0500, Christopher Mulcahy wrote:
> On Tue, 2005-11-08 at 13:38 -0800, john stultz wrote:
> > On Tue, 2005-11-08 at 15:40 -0500, Christopher Mulcahy wrote:
> > > I am running 2.6.14 SMP on an dual-core athlon x2 3800.
> > > The system clock runs at roughly twice normal speed.
> > 
> > Is this a new regression or did the problem occur with 2.6.13 or older
> > kernels?
> This is a new-machine.
> The only other kernel it has seen is the distro-install-kernel ( 2.6.12
> uni-processor (ubuntu-5.10) )  ( this kernel does not have a problem,
> but it is not SMP )
> 
> I will try to find time to build 2.4.13 and 2.4.12 SMP kernels with the
> ~same config to see if they have the same problem. ( I presume I could
> then attach these findings to the original bugzilla report? )

There are a few similar sounding bugs out there:
If its an ATI chipset, check out 
http://bugzilla.kernel.org/show_bug.cgi?id=3927

If its an nvidia chipset, check out
http://bugzilla.kernel.org/show_bug.cgi?id=3341


> > Would you mind opening a kernel bug and attaching your dmesg and config?
> > 
> > http://bugzilla.kernel.org
> > 
> will do.

Please tag me as the owner when you do.

> > 
> > Also try booting w/ "idle=poll" to see if that doesn't clear up the
> > issue.
> > 
> Tried that without results.

Bummer. Your box may not boot, but trying noapic might help as well.

thanks
-john

