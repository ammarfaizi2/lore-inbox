Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVC1N5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVC1N5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVC1NzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:55:25 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:21709 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261764AbVC1Nq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:46:29 -0500
Date: Mon, 28 Mar 2005 08:45:10 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kim Phillips <kim.phillips@freescale.com>, johnpol@2ka.mipt.ru,
       Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050328134510.GV24697@certainkey.com>
References: <1111737496.20797.59.camel@uganda> <424495A8.40804@freescale.com> <20050325234348.GA17411@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325234348.GA17411@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 06:43:49PM -0500, Jeff Garzik wrote:
> 
> Consider what an RNG does:  spews garbage.
> 
> In practical applications, you -do not- want to dedicate the machine to 
> spewing garbage.  The vast majority of users would prefer to use their
> machines for real stuff.  Thus, "extreme RNG consumption" is largely
> irrelevant to sane usage.

I have clients who run online Casinos.  So spewing lots of reliable garbage
is a good thing.  That's why they chose Fortuna.  Bad random data input is
not a factor as long as there is enough trustwothy random data coming in.

JLC
