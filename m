Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319059AbSHMUV3>; Tue, 13 Aug 2002 16:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319063AbSHMUV3>; Tue, 13 Aug 2002 16:21:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40698 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319060AbSHMUV1>; Tue, 13 Aug 2002 16:21:27 -0400
Subject: Re: [PATCH] NUMA-Q disable irqbalance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208131220350.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131220350.7411-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 21:22:55 +0100
Message-Id: <1029270175.20975.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 20:22, Linus Torvalds wrote:
> 
> On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> > 
> > OK, I was being unclear, that's not really what I meant. If I may rephrase:
> > I don't like the performance hit it gives on P3 standard SMP machines (not
> > NUMA-Q) though it does work on there too, and there's no easy way for 
> > people to disable it.
> 
> Well, it makes performance _so_ much better on a P4 that it's not even 
> funny. It's basically a "P4 is unusable with SMP" without it.

On a collection of networking workloads the P4 is about 5% better
performing with the irq balancer off.

