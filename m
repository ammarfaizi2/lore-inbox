Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbVIZNbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVIZNbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVIZNbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:31:50 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:47291 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1750918AbVIZNbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:31:49 -0400
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Michael Bellion <mbellion@hipac.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <200509261516.16565.mbellion@hipac.org>
References: <200509260445.46740.mbellion@hipac.org>
	 <1127733492.6215.274.camel@localhost.localdomain>
	 <200509261516.16565.mbellion@hipac.org>
Content-Type: text/plain
Organization: unknown
Date: Mon, 26 Sep 2005 09:31:37 -0400
Message-Id: <1127741497.6215.345.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-26-09 at 15:16 +0200, Michael Bellion wrote:
> Hi,
> 
> > Can you post some numbers relative to iptables?
> 
> We have some performance tests available at:
> http://www.hipac.org/performance_tests/overview.html
> 
> We also have a list of the independent performance tests we know of:
> http://www.hipac.org/performance_tests/independent.html
> 

Can you please post something against new kernels you are patching
against _today_? I recall these same graphs from a few years back but
even iptables has improved since. 
Any issues you may find can only help you improve.

BTW, your tests were unfair to iptables; you should have had optimized
the rules with the assumption that someone needing that many rules would
probably have needed to do some optimization even with iptables.
Yes, it would only have taken one year to load 256K rules, but it would
have loaded eventually.

> > Some tests with the following parameters would be helpful:
> > - Variable incoming packet rate (in packets per second)
> > - Variable packet sizes
> > - Variable number of users/filters
> > - Effect of adding/removing/modifying policies while under different
> > incoming traffic rates.
> 
> Most of this parameters are used in the performance tests above.
> 
> The effect of adding/removing/modifying policies while under different
> incoming traffic rates has not been tested in the above tests.
> 
> nf-HiPAC is based on a completely dynamic approach.

Very good. Please do more up to date testing and try to include tc
filter as well.

cheers,
jamal


