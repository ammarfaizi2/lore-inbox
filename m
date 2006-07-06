Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWGFTmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWGFTmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWGFTmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:42:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24511 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750765AbWGFTmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:42:46 -0400
Message-ID: <44AD67A9.9020702@garzik.org>
Date: Thu, 06 Jul 2006 15:42:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca> <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com>
In-Reply-To: <44AD658A.5070005@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> The "reordered" thing really only matters on SMP machines, no?  In which 

No.

Pentiums have had out-of-order execution for a while now.  Started with 
the Pentium Pro, I think.

	Jeff


