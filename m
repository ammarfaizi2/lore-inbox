Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVAZBBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVAZBBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVAYXkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51086 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262221AbVAYXSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:18:33 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <amax@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <20050125081704.GC27013@wotan.suse.de>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <20050125081704.GC27013@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 15:18:22 -0800
Message-Id: <1106695102.30884.65.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 09:17 +0100, Andi Kleen wrote:
> On Mon, Jan 24, 2005 at 02:51:29PM -0800, john stultz wrote:
> > All,
> > 	Here is a new release of my time of day proposal, which include ppc64
> > support as well as suspend/resume and cpufreq hooks. For basic summary
> > of my ideas, you can follow this link: http://lwn.net/Articles/100665/
> 
> [...]
> How do vsyscalls (running gettimeofday in user space) fit into your 
> architecture? I don't see any provision for this.

Yea, I had some earlier ideas for it, although they were misconceived.
My plan at the moment is to do it similarly to how x86-64 and my i386
patch did it, but still have it on an arch-per-arch basis.

> Also on x86-64 we plan to keep the cycle time base per CPU, that 
> will likely require some more changes to your architecture too.

I like to hear more details, if you can discuss it. Its interesting,
because I don't quite see how you'd be able to do this.

thanks
-john

