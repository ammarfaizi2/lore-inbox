Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVKUXgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVKUXgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVKUXgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:36:23 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:32518 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932482AbVKUXgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:36:22 -0500
Date: Tue, 22 Nov 2005 10:36:09 +1100
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com, ashutosh.naik@gmail.com
Subject: Re: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
Message-ID: <20051121233609.GB27327@gondor.apana.org.au>
References: <E1EeJu8-0006vr-00@gondolin.me.apana.org.au> <4382563E.50502@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4382563E.50502@student.ltu.se>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 12:20:30AM +0100, Richard Knutsson wrote:
> 
> Am thinking of removing the #ifdef CONFIG_PCI's in other files, to 
> "clean up" the code, but that would introduce this problem again, don't 
> you think it is more readable to make an empty struct when !CONFIG_PCI, 
> then making new pci_*-functions specific to the driver?

I think my version is more readable.  However, it's really up to Jeff
to decide.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
