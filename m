Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267769AbTBRGR3>; Tue, 18 Feb 2003 01:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTBRGR3>; Tue, 18 Feb 2003 01:17:29 -0500
Received: from rth.ninka.net ([216.101.162.244]:62084 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267769AbTBRGR1>;
	Tue, 18 Feb 2003 01:17:27 -0500
Subject: 
From: "David S. Miller" <davem@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
In-Reply-To: <15949.40369.601166.550803@notabene.cse.unsw.edu.au>
References: <15949.40369.601166.550803@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Feb 2003 23:10:37 -0800
Message-Id: <1045552237.4501.8.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 17:53, Neil Brown wrote:
> No.
> My application (which is just using standard rpc server libraries) is
> saying
>   "This is in reply to a request that came in through a given
>   interface".
> 
> It is not reasonable to treat that statement as equivalent to:
>   "This packet must go out that interface"
> 
> which is what appears to be happening.

You misunderstand what this control message knob means during
a sendmsg() then, it means "send this over interface X"

There is no other valid expectation.

I'm curious where you read something that would suggest otherwise
for sendmsg() behavior wrt. ip_pktinfo

