Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTEROwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTEROwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:52:33 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:42506 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262105AbTEROwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:52:31 -0400
Date: Mon, 19 May 2003 01:03:08 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Herbert Xu <herbert@gondor.apana.org.au>, <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
In-Reply-To: <20030518124603.GA12766@fs.tum.de>
Message-ID: <Mutt.LNX.4.44.0305190054220.22329-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Adrian Bunk wrote:

> It seems the cryptographic options don't depend on anything else. What 
> about Herbert's patch plus moving the crypto menu above network support?

It's up to the authors whether they want their modules to always be 
selectable or not.  We can't assume that only the networking wants this.

Think of crypto algorithms like a library: components are enabled
depending on what user-selected features need them.


- James
-- 
James Morris
<jmorris@intercode.com.au>

