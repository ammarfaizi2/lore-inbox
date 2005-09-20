Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVITFLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVITFLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbVITFLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:11:11 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:32728
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932727AbVITFLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:11:09 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
In-Reply-To: <432F96C1.70303@nortel.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
	 <432F3E0F.1010002@nortel.com>
	 <1127170488.24044.291.camel@tglx.tec.linutronix.de>
	 <432F96C1.70303@nortel.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 07:11:17 +0200
Message-Id: <1127193078.24044.303.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 22:57 -0600, Christopher Friesen wrote:
> >>--flight-recorder style logs
> 
> > If you want to implement such stuff efficiently you rely on rdtscll() on
> > x86 or other monotonic easy accessible time souces and not on a
> > permanent call to gettimeofday.
> 
> Not portable across architectures, and doesn't work across all smp/numa 
> environments.  Also not easy to compare with other nodes on the network, 
> whereas with ntp-synch'd nodes you can use gettimeofday() for quite 
> accurate correlations.

Sorry was a stupid argument. Withdrawn herby 

> > Please beware me of red herrings. If application developers code with
> > respect to random OS worst case behaviour then they should not complain
> > that OS N is having an additional add instruction in one of the pathes.
> 
> Actually I'm not complaining about additional add instructions.  I was 
> just suggesting some reasons why apps might reasonably want to know the 
> time frequently.

ok

tglx


