Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVCRJLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVCRJLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVCRJLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:11:16 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:37893 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261528AbVCRJJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:09:29 -0500
Date: Fri, 18 Mar 2005 20:09:03 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: yxie@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: Potential DOS in load_elf_library?
Message-ID: <20050318090903.GA28675@gondor.apana.org.au>
References: <Pine.LNX.4.60.0503180008140.25717@localhost.localdomain> <E1DCDDS-0007K8-00@gondolin.me.apana.org.au> <20050318010501.3190d8c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318010501.3190d8c6.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 01:05:01AM -0800, Andrew Morton wrote:
> 
> I think it'd be better to use epptr everywhere, so we can see that it only
> gets assigned, tested then freed.

Looks good to me.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
