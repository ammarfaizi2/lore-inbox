Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSIEVCE>; Thu, 5 Sep 2002 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSIEVCE>; Thu, 5 Sep 2002 17:02:04 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:21213 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S318159AbSIEVCD>;
	Thu, 5 Sep 2002 17:02:03 -0400
Date: Thu, 5 Sep 2002 16:59:47 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Troy Wilson <tcw@tempest.prismnet.com>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <200209051830.g85IUMdH096254@tempest.prismnet.com>
Message-ID: <Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey, thanks for crossposting to netdev

So if i understood correctly (looking at the intel site) the main value
add of this feature is probably in having the CPU avoid reassembling and
retransmitting. I am willing to bet that the real value in your results is
in saving on retransmits; I would think shoving the data down the NIC
and avoid the fragmentation shouldnt give you that much significant CPU
savings. Do you have any stats from the hardware that could show
retransmits etc; have you tested this with zero copy as well (sendfile)
again, if i am right you shouldnt see much benefit from that either?

I would think it probably works well with things like partial ACKs too?
(I am almost sure it does or someone needs to be spanked, so just
checking).

cheers,
jamal


