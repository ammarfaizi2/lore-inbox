Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWAKSVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWAKSVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWAKSVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:21:05 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:61870 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932432AbWAKSVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:21:04 -0500
Date: Wed, 11 Jan 2006 10:21:21 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: fix hotplug-cpu ->donelist leak
Message-ID: <20060111182121.GF21885@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru> <20060109195933.GE14738@us.ibm.com> <20060110095811.GA30159@in.ibm.com> <43C3C3B5.61D5641@tv-sign.ru> <20060111162809.GC21885@us.ibm.com> <43C55BAF.180F3689@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C55BAF.180F3689@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:25:35PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > This passed a ten-hour RCU torture test, with the torture test augmented
> 
> Thank you!
> 
> > by Vatsa's CPU-hotplug RCU-torture-test patch.
> 
> I can't find this patch, could you point me?

http://marc.theaimsgroup.com/?l=linux-kernel&m=113378075217761&w=2

I just realized that I had failed to ack this one, so just did so.

						Thanx, Paul
