Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUIHSMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUIHSMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUIHSMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:12:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43489 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269324AbUIHSMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:12:03 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <41390622.2010602@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
	 <41381C2D.7080207@mvista.com>
	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>
	 <4138EBE5.2080205@mvista.com>
	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>
	 <41390622.2010602@mvista.com>
Content-Type: text/plain
Message-Id: <1094666844.29408.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Sep 2004 11:07:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 17:02, George Anzinger wrote:
> > Again, monotonic_clock() and friends are NTP adjusted, so drift caused
> > by inaccurate calibration shouldn't be a problem the interval timer code
> > should need to worry about (outside of maybe adjusting its interval time
> > if its always arriving late/early). If possible the timesource
> > calibration code should be improved, but that's icing on the cake and
> > isn't critical.
> > 
> Are you providing a way to predict what clock count provide a given time offset 
> INCLUDING ntp?  If so, cool.  If not we need to get this conversion right.  We 
> will go into this more on your return.

Sorry, I'm not sure what you mean. Mind expanding on the idea while my
brain warms back up?

thanks
-john


