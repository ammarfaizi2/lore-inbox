Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTGAXkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 19:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTGAXkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 19:40:46 -0400
Received: from evil.netppl.fi ([195.242.209.201]:40340 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S264067AbTGAXkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 19:40:45 -0400
Date: Wed, 2 Jul 2003 02:55:07 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GSM PCMCIA cards?
Message-ID: <20030701235507.GA4415@netppl.fi>
References: <20030701115354.7810e350.skraw@ithnet.com> <20030701172718.A11446@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030701172718.A11446@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 05:27:18PM +0200, Vojtech Pavlik wrote:
> On Tue, Jul 01, 2003 at 11:53:54AM +0200, Stephan von Krawczynski wrote:
> 
> > does anybody use a GSM PCMCIA card under Linux? What vendor?
> 
> SonyEricsson/AnyCom GC75 works OK, looks like a serial modem. Triband.
And to be complete, Nokia D211, which has GSM, GPRS and WLAN. Partially
binary-only. Trying to use the WLAN side on the latest RH9 errata kernel for 
more than 5 minutes usually crashes the machine, GSM side works just fine.
Unfortunately life is too short to debug proprietary drivers ;) 

There's also the older Card Phone which has two versions, 1.0 used
a modified pcmcia serial driver. Hackery probably required to
get it working with modern pcmcia code/kernels. 2.0 is 
more or less standard pcmcia serial I believe... 

-- 
Pekka Pietikainen
