Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSGYWF5>; Thu, 25 Jul 2002 18:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSGYWF5>; Thu, 25 Jul 2002 18:05:57 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:64900 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S316579AbSGYWF5>; Thu, 25 Jul 2002 18:05:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Bruce Cran <bruce@cran.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: wrong mtu value in /proc/net/route
Date: Fri, 26 Jul 2002 00:14:30 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020725223410.A18965@steely.transient>
In-Reply-To: <20020725223410.A18965@steely.transient>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020725220557Z316579-685+18235@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 July 2002 23:34, Bruce Cran wrote:
> I've found something strange going on in 2.4 kernels - when I run
> 'netstat -r' I get the routing table from /proc/net/route.   The MSS
> value reported is only 40 bytes, and when I run 'cat
> /proc/net/route I'm told that the _MTU_ is 40 bytes.   I thought the MSS
> was supposed to be the MTU - 40 bytes, not 40 bytes in
> total, where the MTU for ethernet is 1500.  If I run ifconfig, it reports
> the correct MTU of 1500 for eth0 and 16463 for lo.   This computer has a
> NetGear FA311 card, and is running 2.4.19-pre7-ac2, though I've also seen
> this happening on a 2.4.18 kernel.

I see the same values on 2.4.19-rc3-ac3 with two Winbond Electronics Corp 
W89C940 NIC's. no idea what is causing it.

	Rudmer
