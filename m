Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbTAIIYf>; Thu, 9 Jan 2003 03:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTAIIYe>; Thu, 9 Jan 2003 03:24:34 -0500
Received: from goliath.apana.org.au ([202.12.88.44]:49671 "EHLO
	goliath.apana.org.au") by vger.kernel.org with ESMTP
	id <S262210AbTAIIYb>; Thu, 9 Jan 2003 03:24:31 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: wichert@wiggy.net (Wichert Akkerman), linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108130850.GQ22951@wiggy.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.20-686-smp (i686))
Message-Id: <E18WY7C-00021l-00@gondolin.me.apana.org.au>
Date: Thu, 09 Jan 2003 19:32:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman <wichert@wiggy.net> wrote:
>
> 13:57:40.310471 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846112 369670744,nop,nop,sack sack 1 {9360653:9363289} >
> 13:57:40.325396 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9363289:9363509(220) ack 1 win 5712 <nop,nop,timestamp 369670750 846111> [class 0x2]
> 13:57:40.325447 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846113 369670744,nop,nop,sack sack 1 {9360653:9363509} >
> 13:57:40.568652 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670773 846113>
> 13:57:41.121608 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670829 846113>
> 13:57:42.242095 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670941 846113>
> 13:57:44.481379 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369671165 846113>
> 13:57:48.963035 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369671613 846113>

Verify the checksum of that packet, it's probably corrupt.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
