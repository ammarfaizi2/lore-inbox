Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316835AbSFQISG>; Mon, 17 Jun 2002 04:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSFQISF>; Mon, 17 Jun 2002 04:18:05 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:44257 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316835AbSFQISE>; Mon, 17 Jun 2002 04:18:04 -0400
Date: Mon, 17 Jun 2002 09:50:19 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <Pine.LNX.4.44.0206170503380.2941-100000@e2>
Message-ID: <Pine.LNX.4.44.0206170946360.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Ingo Molnar wrote:

> i have planned to submit the irqbalance patch for 2.4-ac real soon, which
> needs this function - current IRQ distribution on P4 SMP boxes is a
> showstopper.

Can we add a config time option for irqbalance? I consider it extra 
overhead for setups which can do the interrupt distribution via hardware 
properly, also irqbalance breaks NUMAQ horribly seeing as it assumes a 
number of things like addressing modes.

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		


