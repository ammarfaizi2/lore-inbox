Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUGHDNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUGHDNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 23:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUGHDNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 23:13:42 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:12297 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265766AbUGHDND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 23:13:03 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: chrisw@osdl.org (Chris Wright)
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil, jmorris@redhat.com, mika@osdl.org
Organization: Core
In-Reply-To: <20040707122525.X1924@build.pdx.osdl.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
Date: Thu, 08 Jul 2004 13:12:41 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
> Fixup another round of sparse warnings of the type:
>        warning: Using plain integer as NULL pointer

What's wrong with using 0 as the NULL pointer? In contexts where
a plain 0 is unsafe, NULL is usually unsafe as well.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
