Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUFHKPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUFHKPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUFHKPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:15:45 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:49936 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265201AbUFHKOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:14:40 -0400
Date: Tue, 8 Jun 2004 20:14:26 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vince@kyllikki.org
Subject: Re: [VGA16FB] Fix bogus mem_start value
Message-ID: <20040608101426.GA26612@gondor.apana.org.au>
References: <20040608100530.GA26292@gondor.apana.org.au> <20040608030906.0dd7d99f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608030906.0dd7d99f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 03:09:06AM -0700, Andrew Morton wrote:
> 
> >  We could simply apply virt_to_phys to it, but somehow I doubt that
> >  is what it's meant to do on arm.  So until we hear from someone who
> >  knows how it works on arm, let's just revert this change.
> 
> Is this tested?

Yes on i386.  It's also what what we've used since the beginning of
time until that change was introduced.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
