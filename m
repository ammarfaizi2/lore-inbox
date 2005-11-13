Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVKMCwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVKMCwi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 21:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVKMCwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 21:52:38 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:5134 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751021AbVKMCwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 21:52:38 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: drzeus@drzeus.cx (Pierre Ossman)
Subject: Re: [PATCH] Register interrupt handler when net device is registered. Avoids missing
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20051108064547.18106.53763.stgit@poseidon.drzeus.cx>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1Eb7yZ-00064D-00@gondolin.me.apana.org.au>
Date: Sun, 13 Nov 2005 13:52:15 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus@drzeus.cx> wrote:
> interrupts if the interrupt mask gets out of sync.

What about fixing the interrupt mask instead rather than keeping
the IRQ handler registered all time?

BTW, you should submit this via Jeff Garzik <jgarzik@pobox.com> and
netdev@vger.kernel.org.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
