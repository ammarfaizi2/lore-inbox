Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWHMHDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHMHDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 03:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWHMHDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 03:03:43 -0400
Received: from vmail.comtv.ru ([217.10.32.17]:7832 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id S1750726AbWHMHDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 03:03:42 -0400
X-UCL: actv
Message-ID: <44DEC069.85C6D3E3@inCTV.ru>
Date: Sun, 13 Aug 2006 06:02:17 +0000
From: Innocenti Maresin <qq@inCTV.ru>
Organization: [ =?KOI8-R?Q?=DA=C1_IP_=C2=C5=DA_=C3=C5=CE=DA=D5=D2=D9?= ] 
 http://internet.comtv.ru/
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.6.13-rc6 i686)
X-Accept-Language: ru, fr, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: remapping IP addresses for inbound and outbound traffic
References: <LKML-nat-0.qq@inCTV.ru> <NBBBIHMOBLOHKCGIMJMDOEBFFMAA.g.tomassoni@libero.it>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni:
 
> I guess you can't do this, since a believe there is a single linux arp table.
> It is not per-interface.

It is a problem generally, but happily not in my case 
because at least one of my networks has this overlapping IP area behind a router. 
More precisely, one network almost entirely stands behind a router. 
I do not need any ARP for IPs those I want to remap. 

 
> If you had hosts with unique IPs on both nets, that would be another story:
> you could use some sort of VPN or Bridge functionality.
> You could also be able to avoid packets passing through the bridged/VPNed interfaces
> thanks to iptables.

May be I do not understand what means "some sort of VPN or Bridge functionality", 
but any solution requiring an extra soft on the client side would be inadequate 
and I will not take such proposals into account. 
My server must accept pure IP from both sides. 
I am not willing to set up packet forwarding, GRE, nor any another "advanced technique". 
Only one simple thing is required: to shift a block of IPs at one interface. 




-- 
qq~~~~\	
/ /\   \
\  /_/ /
 \____/
