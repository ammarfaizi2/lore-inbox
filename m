Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTHQNps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTHQNps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:45:48 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49292 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270243AbTHQNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:45:39 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308171516090038.0043F977@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	 <20030728213933.F81299@coredump.scriptkiddie.org>
	 <200308171509570955.003E4FEC@192.168.128.16>
	 <200308171516090038.0043F977@192.168.128.16>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 14:41:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 14:16, Carlos Velasco wrote:
> So,
> 
> According to RFC 1027:
> http://www.ietf.org/rfc/rfc1027.txt

Proxy ARP only.

>    A.3.  ARP datagram
> 
>       An ARP reply is discarded if the destination IP address does not
>       match the local host address.  

Linux counts all the IP addresses it has as being local host address.

And Linux btw has arpfilter which can do far more than just imitate your
favourite network religion of the week

