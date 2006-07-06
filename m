Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWGFVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWGFVBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWGFVBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:01:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750857AbWGFVBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:01:37 -0400
Date: Thu, 6 Jul 2006 14:00:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
cc: Mark Lord <lkml@rtr.ca>, Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <44AD752D.3090405@nortel.com>
Message-ID: <Pine.LNX.4.64.0607061358560.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca>
 <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com>
 <Pine.LNX.4.64.0607061257130.3869@g5.osdl.org> <44AD752D.3090405@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Chris Friesen wrote:
> 
> But for someone coding to POSIX, is there any reason why they would use
> barriers?  If so, what API would they use?

The POSIX thread api? 

Anyway, who cares? The final word on the kernel is that "volatile" is 
wrong. Arguing against that standpoint is pointless, especially since 
other real kernel developers have already stood up to back me up on this.

In user programs, you can do whatever you damn well please. I don't care, 
it's not my problem.

			Linus
