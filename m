Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVBNBgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVBNBgB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 20:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVBNBgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 20:36:01 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:45060 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261330AbVBNBf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 20:35:58 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kos@arhont.com
Subject: Re: whoops in kernel 2.6.9
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <420FF0DC.4060804@arhont.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1D0V5g-0002r3-00@gondolin.me.apana.org.au>
Date: Mon, 14 Feb 2005 12:31:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin V. Gavrilenko <mlists@arhont.com> wrote:
> Whoops happened when tried to do
> #ip route del blackhole to xxx.xxx.xxx.xxx
> 
> output of dmesg, and lsmod

> EIP is at fib_release_info+0x8b/0xf0

This was fixed in 2.6.10.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
