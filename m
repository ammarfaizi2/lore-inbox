Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266343AbUA2Udn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUA2Udn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:33:43 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:3968 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S266343AbUA2Udm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:33:42 -0500
Date: Thu, 29 Jan 2004 22:33:40 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040129203340.GA1169@elektroni.ee.tut.fi>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040123194714.GA22315@elektroni.ee.tut.fi> <20040125110847.GA10824@elektroni.ee.tut.fi> <20040127155254.GA1656@elektroni.ee.tut.fi> <1075342912.1592.72.camel@cog.beaverton.ibm.com> <20040129143847.GA4544@elektroni.ee.tut.fi> <1075405728.1592.100.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075405728.1592.100.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 11:48:49AM -0800, john stultz wrote:
> On Thu, 2004-01-29 at 06:38, Petri Kaukasoina wrote:
> > Yes, on linux-2.2.24 I can see that /proc/uptime is just the jiffies and
> > btime is current time - jiffies. But in linux-2.6.1 /proc/uptime is now
> > do_posix_clock_monotonic_gettime(), whatever that means, and /proc/uptime
> > gives a correct value. But btime is still gettimeofday-jiffies and it does
> > not stay constant. My patch changed btime to be
> > gettimeofday-do_posix_clock_monotonic_gettime() and after that it stays
> > constant.
> 
> Does George Anzinger's patch work as well?

I must have missed that... Any references?

-Petri
