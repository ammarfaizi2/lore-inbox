Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTERCHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 22:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTERCH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 22:07:29 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:40457 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261923AbTERCH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 22:07:29 -0400
Date: Sun, 18 May 2003 12:19:09 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: davem@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
In-Reply-To: <20030518021034.GA4667@gondor.apana.org.au>
Message-ID: <Mutt.LNX.4.44.0305181218300.21143-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Herbert Xu wrote:

> Trivial patch which makes INET?_{AH,ESP} depend on CRYPTO_HMAC.

See crypto/Kconfig, CRYPTO_HMAC is being defaulted to Y if these protocols 
are selected.


- James
-- 
James Morris
<jmorris@intercode.com.au>

