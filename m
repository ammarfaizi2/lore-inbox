Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSIEWoY>; Thu, 5 Sep 2002 18:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318764AbSIEWoY>; Thu, 5 Sep 2002 18:44:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13789 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318762AbSIEWoX>;
	Thu, 5 Sep 2002 18:44:23 -0400
Message-ID: <1031266115.3d77df4344463@imap.linux.ibm.com>
Date: Thu,  5 Sep 2002 15:48:35 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Troy Wilson <tcw@tempest.prismnet.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
In-Reply-To: <Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.20.67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jamal <hadi@cyberus.ca>:

> So if i understood correctly (looking at the intel site) the main
> value add of this feature is probably in having the CPU avoid
> reassembling and retransmitting. I am willing to bet that the real

Er, even just assembling and transmitting? I'm thinking of the
reduction in things like separate memory allocation calls and looking
up the route, etc..??

> value in your results is in saving on retransmits; I would think
> shoving the data down the NIC and avoid the fragmentation shouldnt
> give you that much significant CPU savings. Do you have any stats

Why do say that? Wouldnt the fact that youre now reducing the
number of calls down the stack by a significant number provide
a significant saving? 

> from the hardware that could show retransmits etc; have you tested
> this with zero copy as well (sendfile) again, if i am right you
> shouldnt see much benefit from that either?

thanks,
Nivedita




