Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422925AbWCXARi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422925AbWCXARi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWCXARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:17:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46007 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422733AbWCXARh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:17:37 -0500
Subject: Re: 2.6.16-mm1
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060323160426.153fbea9.akpm@osdl.org>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <200603232317.50245.Rafal.Wysocki@fuw.edu.pl>
	 <20060323160426.153fbea9.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 16:17:15 -0800
Message-Id: <1143159436.2299.33.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 16:04 -0800, Andrew Morton wrote:
> "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
> >
> > On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> > 
> > On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> > just fine, .config attached):
> 
> hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.
> 
> > }-- snip --{
> > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> > time.c: Detected 1795.400 MHz processor.
> > disabling early console
> > Console: colour dummy device 80x25
> > time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
> > last cli 0x0
> > last cli caller 0x0
> > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > last cli 0x0
> > last cli caller 0x0
> > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> 
> Hi, John.

Hi. :)

Hmmmm. Not sure how this would relate to the TOD bits, but they might be
somehow causing it.

Rafael, could you send me the full dmesg and .config info and I'll try
to find a box to reproduce this on?

thanks
-john


