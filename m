Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUIWEsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUIWEsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUIWEsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:48:04 -0400
Received: from [142.46.200.198] ([142.46.200.198]:19861 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S268269AbUIWEr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:47:57 -0400
Message-Id: <200409230446.i8N4kr39005611@guinness.s2io.com>
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'Nivedita Singhvi'" <niv@us.ibm.com>
Cc: "'Andi Kleen'" <ak@suse.de>, "'David S. Miller'" <davem@davemloft.net>,
       "'John Heffner'" <jheffner@psc.edu>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: The ultimate TOE design
Date: Wed, 22 Sep 2004 21:46:47 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <4151DDFF.6000902@us.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
thread-index: AcSg4Wls/1uX1Fa0Q4apuZMmesL9gQADYFIQ
X-Spam-Score: -103.3
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_10,FORGED_MUA_OUTLOOK,IN_REP_TO,MISSING_OUTLOOK_NAME,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > It's a bit painful to setup, but in general with 9k jumbos 
> and TSO we 
> > were able to get close to pci-x 133 limit - both in LAN and 
> WAN tests.
> > Leonid
> 
> Cool, but a very specific environment, no? ;)

Define specific environment :-). We are running common tcp benchmarks like
nttcp or iperf or Chariot or filesystem applications on a very generic white
boxes, with generic OS/settings.

> 
> What concerns me about all this is that it seems so very 
> host-centric design. Wouldn't it be nice if we had a little 
> bit more network-centric worldview when designing network 
> infrastructure?
> 
> It isn't just a matter of how had we can push stuff out, it 
> also matters how much the network can take.
> Blasting tens of gigs into the ether seems all very exciting 
> sexy and cool, but suited for dedicated links or network 
> attached storage channels, not general-purpose networking on 
> the Internet or intra-nets.

This is somewhat different from IB or FC "miniature networks", 
some/most of 10GbE testing runs in existing datacenters or over 
existing long-haul links - see for example
http://sravot.home.cern.ch/sravot/Networking/10GbE/LSR_041504.htm

Cheers, Leonid

> 
> And if that is the case, we're talking about a much smaller 
> market (but perhaps a more profitable one ;))...
> 
> thanks,
> Nivedita
> 
> 
> 

