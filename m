Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130045AbRCGEcM>; Tue, 6 Mar 2001 23:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130062AbRCGEcD>; Tue, 6 Mar 2001 23:32:03 -0500
Received: from rtp-msg-core-1.cisco.com ([161.44.11.97]:17372 "EHLO
	rtp-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S130045AbRCGEbs>; Tue, 6 Mar 2001 23:31:48 -0500
Message-Id: <4.3.2.7.2.20010307153216.01b85d58@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 07 Mar 2001 15:33:44 +1100
To: David Luyer <david_luyer@pacific.net.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Incoming TCP TOS: A simple question, I would have
  thought...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103070400.f2740jT16998@typhaon.pacific.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

getsockopt(fd, SOL_IP, IP_TOS, ..


cheers,

lincoln.

At 03:00 PM 7/03/2001 +1100, David Luyer wrote:

>I've scrolled through various code in net/ipv4, and I can't see how to query
>the TOS of an incoming TCP stream (or at the least, the TOS of the SYN which
>initiated the connection).
>
>Someone has sent in a feature request for squid which would require this,
>presumably so they can set the TOS in their routers and have the squid caches
>honour the TOS to select performance (via delay pools, multiple parents,
>different outgoing IP or similar).  However I can't see how to get the TOS for
>a TCP socket out of the kernel short of having an open raw socket watching for
>SYNs and looking at the TOS on them.
>
>Any pointers?
>
>David.
>--
>David Luyer                                        Phone:   +61 3 9674 7525
>Engineering Projects Manager   P A C I F I C       Fax:     +61 3 9699 8693
>Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
>http://www.pacific.net.au/                         NASDAQ:  PCNTF
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

