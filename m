Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUIPF1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUIPF1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIPF1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:27:15 -0400
Received: from [142.46.200.198] ([142.46.200.198]:5854 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S267165AbUIPF1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:27:12 -0400
Message-Id: <200409160525.i8G5PtqG009228@guinness.s2io.com>
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: <hadi@cyberus.ca>, "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'David S. Miller'" <davem@davemloft.net>, <alan@lxorguk.ukuu.org.uk>,
       <paul@clubi.ie>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: The ultimate TOE design
Date: Wed, 15 Sep 2004 22:25:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSbiENKKFilyoSbReWBeZCyQiJppwAIlPwg
In-Reply-To: <1095296279.1064.80.camel@jzny.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Spam-Score: -103.3
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_10,FORGED_MUA_OUTLOOK,IN_REP_TO,MISSING_OUTLOOK_NAME,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: jamal [mailto:hadi@cyberus.ca] 
> Sent: Wednesday, September 15, 2004 5:58 PM
> To: Jeff Garzik
> Cc: David S. Miller; alan@lxorguk.ukuu.org.uk; paul@clubi.ie; 
> netdev@oss.sgi.com; leonid.grossman@s2io.com; 
> linux-kernel@vger.kernel.org
> Subject: Re: The ultimate TOE design
> 
> Jeff,
> You are only allowed to start a TOE thread only every six months ;->
> 
> On a serious note, I think that PCI-express (if it lives upto its
> expectation) will demolish dreams of a lot of these TOE investments.
> Our problem is NOT the CPU right now (80% idle processing 
> 450Kpps forwarding). Bus and memory distance/latency are. 

In servers, both bottlenecks are there - if you look at the cost of TCP and
filesystem processing at 10GbE, CPU is a huge problem (and will be for
foreseeable future), even for fastest 64-bit systems. 
I agree though that bus and memory are bigger issues, this is exactly the
reason for all these RDMA over Ethernet investments :-)
Anyways, did not mean to start an argument - with all the new CPU, bus and
HBA technologies coming to the market it will be another 18-24 months before
we know what works and what doesn't...
Leonid


>If 
> intel would get rid of the big conspiracy in the form of 
> chipset division and just integrate the MC like AMD is, we'll 
> be on our our way to kill TOE and a lot of the network 
> processors (like the IXP). Dang, running Linux is more 
> exciting than microcoding things to fit into a 2Kword program store. 
> 
> I rest my canadiana $.02 
> 
> cheers,
> jamal
> 

