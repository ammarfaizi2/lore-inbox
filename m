Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVCXEtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVCXEtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVCXEtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:49:17 -0500
Received: from maxipes.logix.cz ([217.11.251.249]:4305 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S263028AbVCXEtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:49:12 -0500
Message-ID: <424246BF.6090108@logix.cz>
Date: Thu, 24 Mar 2005 16:49:03 +1200
From: Michal Ludvig <michal@logix.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David McCullough <davidm@snapgear.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	<20050324043300.GA2621@havoc.gtf.org> <20050324044621.GC3124@beast>
In-Reply-To: <20050324044621.GC3124@beast>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David McCullough wrote:

> Are you talking about /dev/hw_random ?  If not then sorry I didn't see it :-(
> 
> On a lot of the small systems I work on,  /dev/random is completely
> unresponsive,  and all the apps use /dev/random,  not /dev/hw_random.
> 
> Would you suggest making /dev/random point to /dev/hw_random then ?

Or feed the entropy pool from hw_random?

Michal Ludvig
