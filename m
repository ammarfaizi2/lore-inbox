Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTKJKT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 05:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTKJKT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 05:19:58 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:17416 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262655AbTKJKT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 05:19:56 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: albert@users.sf.net (Albert Cahalan), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cfq + io priorities
Organization: Core
In-Reply-To: <1068428977.722.65.camel@cube>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AJ994-0002xM-00@gondolin.me.apana.org.au>
Date: Mon, 10 Nov 2003 21:19:42 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> wrote:
> 
> Sure, but do it in a way that's friendly to
> all the apps and admins that only know "nice".
> 
> nice_cpu   sets CPU niceness
> nice_net   sets net niceness
> nice_disk  sets disk niceness
> ...
> nice       sets all niceness values at once

That's a user space problem.  No matter what Jens does, you can always
make nice(1) do what you said.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
