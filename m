Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVARWpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVARWpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVARWpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:45:05 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:27653 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261460AbVARWoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:44:54 -0500
Date: Wed, 19 Jan 2005 09:42:48 +1100
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050118224248.GA17785@gondor.apana.org.au>
References: <20050117183708.GD4348@tuxdriver.com> <20050117203930.GA9605@gondor.apana.org.au> <20050117214420.GH4348@tuxdriver.com> <20050117232323.GA21365@gondor.apana.org.au> <20050118180745.GA6883@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118180745.GA6883@tuxdriver.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 01:07:47PM -0500, John W. Linville wrote:
> 
> No, that does not fix it. :-(  In fact, it doesn't seem to alter the
> problem at all...

OK.  In that case I agree with your patch.  The overruns that I
attributed to it were probably caused by other bugs that's been
fixed since.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
