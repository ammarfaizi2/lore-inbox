Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318970AbSHMRhG>; Tue, 13 Aug 2002 13:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319001AbSHMRhG>; Tue, 13 Aug 2002 13:37:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50424 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318970AbSHMRhF>; Tue, 13 Aug 2002 13:37:05 -0400
Subject: Re: [PATCH] NUMA-Q disable irqbalance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1996570000.1029259495@flay>
References: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com>
	<1029257866.20980.54.camel@irongate.swansea.linux.org.uk> 
	<1996570000.1029259495@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 18:38:27 +0100
Message-Id: <1029260307.22847.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 18:24, Martin J. Bligh wrote:
> > In the 2.4-ac tree it is a dynamic disable keyed off the mp 1.4 tables.
> > That's how James Cleverdon (I think it was he) implemented the detection
> > logic and mixed summit/sane-pc kernel build that seems to work well now
> 
> The trouble with that is that is it doesn't provide an interface for people to
> disable it by hand for the many cases where constantly reprogramming 
> the IO-APIC reduces the performance of their workload.

I have zero problems with also being able to manually disable it

