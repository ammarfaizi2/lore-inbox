Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUKSCAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUKSCAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKSB6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:58:24 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:45579 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261221AbUKSBzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:55:22 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pluto@pld-linux.org (Pawel Sikora)
Subject: Re: [oops] tcp_set_skb_tso_segs
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <Pine.LNX.4.60.0411181835010.594@plus.ds14.agh.edu.pl>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CUxzD-0002wq-00@gondolin.me.apana.org.au>
Date: Fri, 19 Nov 2004 12:54:55 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Sikora <pluto@pld-linux.org> wrote:
> 
> I have two machines:
> 
> A: (at home) 2.6.10rc1+cset20041025_0606+pom_ng_snap20040609+ADSL
> B: (at work) winxp+putty+DSL
> 
> Step 1: I connect from windows system to my PLD-Linux box using putty.
> Step 2: I'm getting an oops after random time.
> 
> The ooops is caused by divide by zero (line 443: factor /= mss_std;)

This should be fixed in 2.6.10-rc2.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
