Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272317AbTHIKQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272321AbTHIKQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:16:53 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6664 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272317AbTHIKQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:16:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
In-Reply-To: <20030809015142.56190015.davem@redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.21-2-686-smp (i686))
Message-Id: <E19lQgI-0003ry-00@gondolin.me.apana.org.au>
Date: Sat, 09 Aug 2003 20:10:38 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> wrote:
> 
> I believe the C language allows for systems where the NULL pointer is
> not zero.

It does.  However it also says that whenever a pointer is compared
with the integer constant 0 it must be equal if and only if it is
a NULL pointer.

    An integer constant expression with the value 0, or such an expression
    cast to type void *, is called a null pointer constant.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
