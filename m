Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274509AbRITTTL>; Thu, 20 Sep 2001 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274524AbRITTTB>; Thu, 20 Sep 2001 15:19:01 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:25092 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S274509AbRITTSx>;
	Thu, 20 Sep 2001 15:18:53 -0400
Date: Thu, 20 Sep 2001 22:19:04 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Allen Lau <pflau@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict interface arp patch for Linux 2.4.2
In-Reply-To: <OFF5C2EACC.84AC7208-ON85256ACD.0058E6BB@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.33.0109202118170.913-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 20 Sep 2001, Allen Lau wrote:

> I want to bring your attention to a Linux ARP patch we plan to use for load balancing and server
> clustering.  The available arp filter and hidden patch are not completely satisfactory. The following

	Can you explain what setup can't be build using arp_filter,
hidden or rp_filter and particulary where "hidden" fails for clusters,
it is very interesting?

> To generalize, each real server may have multiple nic's of different types. The task becomes one of
> maintaining strict identity of each of the real and virtual ip addresses.  The Linux ARP has the
> following behaviors which are problematic for maintaining strict interface identify.
>
>    1) box responds to arp on all interfaces on the same wire for an IP address (arp race)

	rp_filter and arp_filter can help here but this "arp race" is not
an evil in some setups

Regards

--
Julian Anastasov <ja@ssi.bg>

