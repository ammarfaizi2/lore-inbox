Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVC1Vfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVC1Vfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVC1Vfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 16:35:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:46608 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262076AbVC1Vf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 16:35:28 -0500
Date: Tue, 29 Mar 2005 07:30:20 +1000
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Kim Phillips <kim.phillips@freescale.com>,
       johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050328213020.GA14638@gondor.apana.org.au>
References: <1111737496.20797.59.camel@uganda> <424495A8.40804@freescale.com> <20050325234348.GA17411@havoc.gtf.org> <20050328134510.GV24697@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328134510.GV24697@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 08:45:10AM -0500, Jean-Luc Cooke wrote:
> 
> I have clients who run online Casinos.  So spewing lots of reliable garbage
> is a good thing.  That's why they chose Fortuna.  Bad random data input is
> not a factor as long as there is enough trustwothy random data coming in.

I don't think the Casino operators will be very happy when their supposed
hardware RNGs degenerate into software RNGs because it's feeding all zeros
into /dev/random and nobody noticed...
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
