Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263595AbUJ3Fsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUJ3Fsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 01:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbUJ3Fsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 01:48:36 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56325 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263595AbUJ3Fs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 01:48:27 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: parker@citynetwireless.net
Subject: Re: ICMP ttl-exceeded packets not sourced correctly
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20041029010721.GA25817@core.citynetwireless.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CNm62-0000Df-00@gondolin.me.apana.org.au>
Date: Sat, 30 Oct 2004 15:48:14 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parker@citynetwireless.net wrote:
>
> ICMP ttl-exceeded code's response should not be originated from the interface
> holding the route, but should be origianted from the interface that got hit
> with the traceroute.

What if the interface is a receive-only interface?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
