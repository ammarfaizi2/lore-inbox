Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUBYV7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUBYVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:47:50 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:25557 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261636AbUBYVo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:44:58 -0500
Subject: Re: cryptoapi OMAC (was: cryptoapi highmem bug)
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20040225205952.GB7140@certainkey.com>
References: <20040224223425.GA32286@certainkey.com>
	 <1077663682.6493.1.camel@leto.cs.pocnet.net>
	 <20040225043209.GA1179@certainkey.com>
	 <20040224220030.13160197.akpm@osdl.org>
	 <20040225153126.GA7395@leto.cs.pocnet.net>
	 <20040225155121.GA7148@leto.cs.pocnet.net>
	 <20040225154453.GB4218@certainkey.com>
	 <1077725621.7221.0.camel@leto.cs.pocnet.net>
	 <20040225160935.GD4218@certainkey.com>
	 <20040225181131.GA8983@leto.cs.pocnet.net>
	 <20040225205952.GB7140@certainkey.com>
Content-Type: text/plain
Message-Id: <1077745486.6707.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 22:44:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 25.02.2004 schrieb Jean-Luc Cooke um 21:59:

> Then apply this:
>   http://jlcooke.ca/lkml/crypto_omac_hmac_ctr_25feb2004.patch
> 
> This is my HMAC/OMAC/CTR patch.  I think I fixed your HMAC issue.
> I was giving a scatterlist a stack memory reference (!).

Hmm? That's not a problem per se.

I will look at it. But I still see a lot of room for improvement
especially concerning the cipher.c changes. And I don't think all of
your changes to the digest code are really necessary.


