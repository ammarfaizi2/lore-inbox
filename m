Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTKBVJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTKBVJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:09:57 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:19974 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261823AbTKBVJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:09:55 -0500
Date: Mon, 3 Nov 2003 08:09:42 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031102210942.GA9635@gondor.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031102095441.GA5248@gondor.apana.org.au> <3FA4F085.4080002@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA4F085.4080002@namesys.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 02:54:45PM +0300, Hans Reiser wrote:
>
> Why in the world do you guys do this?  Andrew and Marcelo do a good job, 
> and I haven't heard much complaint about patches being ignored by them, 
> so follow the leader.  If you have patches you need, send them to them.

Andrew and Marcelo do an excellent job.  I have never said otherwise
nor attempted to infer that.

The reasons that we need patches are mostly the same as other distributions:

1. Our release schedule is different from the vanilla kernels.

When we release a kernel based on a vanilla release there may be bug
fixes that are going to be in the next vanilla release that we can
apply straight away.

2. Our goals are different from the vanilla kernel.

Some issues are not critical to the vanilla kernel, e.g., IDE modules
but are release-critical for us.

3. Licensing problems.

This is specific to Debian.  For anything to be included in our release,
it has to pass the DFSG.  The vanilla kernel does not have this
restriction so we may need to remove bits before it's suitable for us.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
