Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVAYAfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVAYAfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVAYAeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:34:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:32242 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261779AbVAYAdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:33:52 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.58.0501241606240.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com>
	 <1106611416.30884.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0501241606240.17986@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 16:33:42 -0800
Message-Id: <1106613222.30884.34.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 16:08 -0800, Christoph Lameter wrote:
> On Mon, 24 Jan 2005, john stultz wrote:
> > Yep, performance is a big concern. Re-working ntp_scale() is still on my
> > TODO list. I just didn't get to it in this release.
> 
> This is a hopeless endeavor if you look at the function.
> Throw ntp_scale out and calculate a scaling factor during the ticks. At
> tick time then you may forward the clock a few ns in order to correct it
> otherwise monkey around with the scaling factor.

We talked about this last time. I do intend to re-work ntp_scale() so
its not a function call, much as you describe above.

hopelessly endeavoring,
-john 


