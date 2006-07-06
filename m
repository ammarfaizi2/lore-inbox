Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWGFThS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWGFThS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWGFThS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:37:18 -0400
Received: from rtr.ca ([64.26.128.89]:36744 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750765AbWGFThR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:37:17 -0400
Message-ID: <44AD666B.1060500@rtr.ca>
Date: Thu, 06 Jul 2006 15:37:15 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca> <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com>
In-Reply-To: <44AD658A.5070005@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
>
> The "reordered" thing really only matters on SMP machines, no?

Also (very much!) for device drivers.

Cheers
