Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSGZKKe>; Fri, 26 Jul 2002 06:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSGZKKe>; Fri, 26 Jul 2002 06:10:34 -0400
Received: from [196.26.86.1] ([196.26.86.1]:50050 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317439AbSGZKKd>; Fri, 26 Jul 2002 06:10:33 -0400
Date: Fri, 26 Jul 2002 12:31:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc3-ac2 SMP
In-Reply-To: <200207251348.26136.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207261229250.19598-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
On Thu, 25 Jul 2002, James Cleverdon wrote:

> On our NUMA P6 box, we found that the local APICs would occasionally start 
> spasming with error interrupts.  An APIC bus analyzer didn't show any kind of 
> errors on the APIC bus.  They would just weird out and all attempts to clear 
> the error had no effect.  We never did find a solution to that one or get an 
> adequate explanation from Intel.  The only kludge that worked was to turn off 
> the APIC error interrupt.
> 
> Naturally, the cleaned up version of the apic_state_dump patch wouldn't do 
> that, or would make it an option.

Since you have the bus analyzer, how frequent (if at all) have you seen 
the EOI register being written to without any bit set in the ISR?

Thanks,
	Zwane

-- 
function.linuxpower.ca

