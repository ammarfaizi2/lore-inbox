Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTLDUxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTLDUxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:53:30 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:48140 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261928AbTLDUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:53:30 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: torvalds@osdl.org (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
Organization: Core
In-Reply-To: <Pine.LNX.4.58.0312031721210.2055@home.osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AS0TP-0003ga-00@gondolin.me.apana.org.au>
Date: Fri, 05 Dec 2003 07:53:19 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Really? This actually makes a difference for you? I don't see why it
> should matter: even if the sector offsets would overflow, why would that
> cause _oopses_?

Apart from the printk, he also changed dev_info_t which means that any
place that uses it will be using the 64-bit type now.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
