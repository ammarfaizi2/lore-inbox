Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVJJCxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVJJCxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 22:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVJJCxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 22:53:18 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:2067 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932327AbVJJCxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 22:53:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jsmith@drexel.edu (Justin R. Smith)
Subject: Re: Instability in kernel version 2.6.12.5
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <43455F33.7020102@drexel.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EOnme-0002gg-00@gondolin.me.apana.org.au>
Date: Mon, 10 Oct 2005 12:53:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin R. Smith <jsmith@drexel.edu> wrote:
> 
> Examining the system logs disclosed that someone attempted to hack my 
> system at 2331 (the time the clock was frozen at) by trying to initiate 
> about 200 ssh connections with randomly generated user ids over a very 
> short time (a few seconds).
> 
> Any suggestions?

Try booting with nolapic.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
