Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSIFEQg>; Fri, 6 Sep 2002 00:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSIFEQf>; Fri, 6 Sep 2002 00:16:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42183 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318529AbSIFEQf>; Fri, 6 Sep 2002 00:16:35 -0400
Message-ID: <1031286047.3d782d1f27162@imap.linux.ibm.com>
Date: Thu,  5 Sep 2002 21:20:47 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <Pine.GSO.4.30.0209052129580.21731-100000@shell.cyberus.ca> <1031283490.3d7823228d9ed@imap.linux.ibm.com> <20020905.205842.127265672.davem@redhat.com>
In-Reply-To: <20020905.205842.127265672.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.33.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "David S. Miller" <davem@redhat.com>:

> >   ifconfig -a and netstat -rn would also be nice to have..
>    
> TSO gets turned off during retransmits/SACK and the card does not
> do
> retransmits.
> 
> Can we move on in this conversation now? :-)

Sure :). The motivation for seeing the stats though would
be to get an idea of how much retransmission/SACK etc 
activity _is_ occurring during Troy's SpecWeb runs, which
would give us an idea of how often we're actually doing
segmentation offload, and better idea of how much gain
its possible to further get from this(ahem) DMA coalescing :).
Some of Troy's early runs had a very large number of
packets dropped by the card.

thanks,
Nivedita


