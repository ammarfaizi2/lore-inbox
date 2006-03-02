Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWCBBcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWCBBcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWCBBcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:32:17 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:41737
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751282AbWCBBcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:32:16 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bunk@stusta.de (Adrian Bunk)
Subject: Re: [2.6 patch] make UNIX a bool
Cc: dtor_core@ameritech.net, jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20060301175852.GA4708@stusta.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FEcfG-000486-00@gondolin.me.apana.org.au>
Date: Thu, 02 Mar 2006 12:31:34 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> 
> It does also matter in the kernel image size case, since you have to put 
> enough modules to the other medium for having a effect bigger than the
> kernel image size increase from setting CONFIG_MODULES=y.

That's not very difficult considering the large number of modules that's
out there that a system may wish to use.

Anyway, getting back to the original point if AF_UNIX is using something
that's so under the hood that it has to be hidden, perhaps what we really
need is a better abstraction?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
