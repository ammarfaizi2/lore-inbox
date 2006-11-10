Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161870AbWKJPpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161870AbWKJPpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161872AbWKJPpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:45:13 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:51391 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1161870AbWKJPpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:45:11 -0500
Message-ID: <45549E0E.6090901@nortel.com>
Date: Fri, 10 Nov 2006 09:43:10 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de> <1163146206.8335.183.camel@localhost.localdomain> <20061110005020.4538e095.akpm@osdl.org>  <20061110085728.GA14620@elte.hu> <1163153670.7900.16.camel@localhost.localdomain>
In-Reply-To: <1163153670.7900.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2006 15:43:15.0002 (UTC) FILETIME=[EF74F9A0:01C704DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-11-10 am 09:57 +0100, ysgrifennodd Ingo Molnar:

>>We should wait until CPU makers get their act together and implement a 
>>TSC variant that is /architecturally promised/ to have constant 
>>frequency (system bus frequency or whatever) and which never stops.
> 
> This will never happen for the really big boxes, light is just too
> slow... Our current TSC handling is not perfect but the TSC is often
> quite usable.

This hypothetical clock wouldn't have to run full speed, would it?  You 
could have a 1MHz clock distributed across even a large system fairly 
easily.

Wouldn't that be good enough?

Chris

