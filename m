Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVCXEdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVCXEdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVCXEdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:33:46 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:27536 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262401AbVCXEdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:33:40 -0500
Date: Wed, 23 Mar 2005 23:33:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: David McCullough <davidm@snapgear.com>
Cc: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324043300.GA2621@havoc.gtf.org>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324042708.GA2806@beast>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 02:27:08PM +1000, David McCullough wrote:
> 
> Hi all,
> 
> Here is a small patch for 2.6.11 that adds a routine:
> 
> 	add_true_randomness(__u32 *buf, int nwords);
> 
> so that true random number generator device drivers can add a entropy
> to the system.  Drivers that use this can be found in the latest release
> of ocf-linux,  an asynchronous crypto implementation for linux based on
> the *BSD Cryptographic Framework.
> 
> 	http://ocf-linux.sourceforge.net/
> 
> Adding this can dramatically improve the performance of /dev/random on
> small embedded systems which do not generate much entropy.

We've already had hardware RNG support for a while now.

No kernel patching needed.

	Jeff



