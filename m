Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBBKuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBBKuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 05:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVBBKuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 05:50:04 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:40456 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261255AbVBBKuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 05:50:00 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: zlynx@acm.org (Zan Lynx)
Subject: Re: [PATCH 2/8] lib/sort: Replace qsort in XFS
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1107318673.15928.68.camel@localhost>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CwI3n-0000lb-00@gondolin.me.apana.org.au>
Date: Wed, 02 Feb 2005 21:48:35 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx <zlynx@acm.org> wrote:
> 
> And you get in the habit of using 0 instead of NULL and before you know
> it you've used it in a variable argument list for a GTK library call on
> an AMD64 system and corrupted the stack. :-)

Using NULL without a cast is equally broken in a variadic context.
Sure it doesn't break on AMD64 but it'll break on platforms where
NULL pointers of different types have different representations.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
