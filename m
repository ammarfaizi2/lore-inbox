Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTFDMuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTFDMuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:50:13 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:25862 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261861AbTFDMuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:50:12 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: Re: system clock speed too high?
In-Reply-To: <E19NUrl-0002xI-00@gondolin.me.apana.org.au>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19NXuq-0003HM-00@gondolin.me.apana.org.au>
Date: Wed, 04 Jun 2003 23:02:56 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> I see exactly the opposite.  The time is ~2.5 times slower with
> 2.4.21-rc6.
> 
> This is actually in a VMware setup on a P4 machine.  The same setup
> runs 2.4.20, 2.5.69 and 2.5.70 correctly.

That was my stupidity by not connecting the RTC.  2.5 just copes with
it much better so I didn't notice.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
