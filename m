Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265277AbUEUX6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUEUX6D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUEUXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:54:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:29197 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264886AbUEUXf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:35:56 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: oliver@neukum.org (Oliver Neukum)
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Organization: Core
In-Reply-To: <200405211920.32187.oliver@neukum.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BRJY0-0006hl-00@gondolin.me.apana.org.au>
Date: Sat, 22 May 2004 09:35:28 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.org> wrote:
> 
> Possible, but unlikely. If there can be a deadlock if they are frozen in
> reverse order, the same problem existed during creation and needed
> to be specially handled.

So exactly which kernel threads will dead lock when frozen in the wrong
order? So far I've only seen user process vs. kernel thread examples.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
