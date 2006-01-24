Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWAXUdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWAXUdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 15:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWAXUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 15:33:04 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:13068 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964849AbWAXUdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 15:33:03 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Knut_Petersen@t-online.de (Knut Petersen)
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller 11ab:4362 (rev 19)
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <43D5F6DD.70702@t-online.de>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au>
Date: Wed, 25 Jan 2006 07:32:36 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen <Knut_Petersen@t-online.de> wrote:
>
> "ethtool -K eth0 rx off" does cure my problem with sky2.
> 
> Anybody is invited to send patches as the problem is 100% reproducible here.

Does the problem go away if you disable conntrack by unloading its module?

Please try to capture the offending ICMP packet with tcpdump and show us
what it looks like.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
