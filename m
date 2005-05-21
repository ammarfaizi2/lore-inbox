Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVEUHSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVEUHSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 03:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVEUHSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 03:18:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53513 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261683AbVEUHS0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 03:18:26 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kernel@linuxace.com (Phil Oester)
Subject: Re: 2.6.12-rc4 random oopses
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20050519153324.GA17914@linuxace.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DZOFT-0001JJ-00@gondolin.me.apana.org.au>
Date: Sat, 21 May 2005 17:18:15 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester <kernel@linuxace.com> wrote:
> I've been attempting to upgrade a 2.6.10 box to 2.6.11 or 2.6.12-rc4,
> and keep getting seemingly random oopses.  I've attached 4 of them below
> for review.  The first 2 occurred without frame pointers enabled, the
> second 2 with.  nmi_watchdog was enabled on all but the last one, as
> I read about some potential problems with it recently.
> 
> Any ideas?

How long can your machine stay up under 2.6.11/2.6.12-rc4? Is 2.6.10
still stable if rebuild it?

If 2.6.10 is still proving to be stable, then please do a bisection
search on the releases between 2.6.10/2.6.11.  That may be the only
way we can track this problem down.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
