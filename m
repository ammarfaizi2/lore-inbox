Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVAZBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVAZBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVAYXke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:34 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:49165 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262230AbVAYXUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:20:04 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bdschuym@pandora.be (Bart De Schuymer)
Subject: Re: 2.6.11-rc2: Badness in local_bh_enable at kernel/softirq.c:140
Cc: earny@net4u.de, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1106685033.5418.0.camel@localhost.localdomain>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CtZxd-0000s1-00@gondolin.me.apana.org.au>
Date: Wed, 26 Jan 2005 10:19:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart De Schuymer <bdschuym@pandora.be> wrote:
> 
> Thanks for posting this. I was just about to go on a wild goose chase.
> Any idea what patch fixed it?

It's this one:

http://article.gmane.org/gmane.linux.kernel/273477
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
