Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCWLJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCWLJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 06:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVCWLJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 06:09:17 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:13323 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261541AbVCWLJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 06:09:14 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jmoyer@redhat.com
Subject: Re: unused 'size' assignment in filemap_nopage
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <16960.37814.651437.634849@segfault.boston.redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DE3jC-0001Lq-00@gondolin.me.apana.org.au>
Date: Wed, 23 Mar 2005 22:08:46 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> wrote:
> 
> After this, size is not referenced.  So, either this potential reassignment
> of size is superfluous, or we are missing some other code later on in the
> function.  If it is the former, I've attached a patch which will remove the
> code.

Yes it's obsolete.  You can remove endoff as well.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
