Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQLCOOH>; Sun, 3 Dec 2000 09:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbQLCON5>; Sun, 3 Dec 2000 09:13:57 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:40992 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129716AbQLCONo>; Sun, 3 Dec 2000 09:13:44 -0500
Date: Sun, 3 Dec 2000 07:43:01 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux 
In-Reply-To: <2776.975802846@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.96.1001203074055.23089B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Keith Owens wrote:
> If you go down this path, please add a standard performance monitoring
> method to query the current capacity of an interface.
> to report "eth0 is handling 1 Megabyte/second, but we cannot tell if
> that is 90% (10BaseT) or 9% (100BaseT) utilization".  We should report
> capacity rather than speed because speed alone is not the controlling
> factor, other things like half or full duplex affect the capacity.

Well, ethtool interface supports reporting media selection as well as
[re]setting media setting.  I dunno if we could report what capacity
an interface is handling without adding code to hot paths...

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
