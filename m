Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317965AbSGPUBn>; Tue, 16 Jul 2002 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317968AbSGPUBm>; Tue, 16 Jul 2002 16:01:42 -0400
Received: from addr-mx02.addr.com ([209.249.147.146]:56836 "EHLO
	addr-mx02.addr.com") by vger.kernel.org with ESMTP
	id <S317965AbSGPUBk>; Tue, 16 Jul 2002 16:01:40 -0400
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
From: Daniel Gryniewicz <dang@fprintf.net>
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207162148040.1484-100000@u.domain.uli>
References: <Pine.LNX.4.44.0207162148040.1484-100000@u.domain.uli>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jul 2002 16:04:50 -0400
Message-Id: <1026849894.3520.5.camel@athena.fprintf.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 18:32, Julian Anastasov wrote:
> 
> 	Hello,
> 
> 	It seems you don't like the way ARP is replied in Linux. But
> note that ARP follows IP, i.e. Linux replies on each device where it
> is willing to accept IP for the same path. Such behaviour is caused by
> the way IP is set by default in RFC1812: Source Address Validation
> is disabled (rp_filter=0).
> 

<heavily snipped>

Okay, I have no problem with this. What I have a problem with is Linux
sending an ARP request out an interface and using the address of
*another interface* as the tell address.  This is just broken.

-- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary


