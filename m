Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTKCKUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTKCKUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:20:17 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:54154 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261956AbTKCKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:20:11 -0500
X-Sender-Authentication: net64
Date: Mon, 3 Nov 2003 11:20:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: reiser@namesys.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at
 fs/buffer.c:431"
Message-Id: <20031103112008.5ac6a6cc.skraw@ithnet.com>
In-Reply-To: <20031102210942.GA9635@gondor.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
	<20031102014011.09001c81.akpm@osdl.org>
	<20031102210942.GA9635@gondor.apana.org.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003 08:09:42 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

Forgive my comments unrelated to the primary topic, but I think additional
voices may do something good to your general idea of a distro.

> On Sun, Nov 02, 2003 at 02:54:45PM +0300, Hans Reiser wrote:
> >
> > Why in the world do you guys do this?  Andrew and Marcelo do a good job, 
> > and I haven't heard much complaint about patches being ignored by them, 
> > so follow the leader.  If you have patches you need, send them to them.
> 
> Andrew and Marcelo do an excellent job.  I have never said otherwise
> nor attempted to infer that.
> 
> The reasons that we need patches are mostly the same as other distributions:
> 
> 1. Our release schedule is different from the vanilla kernels.
> 
> When we release a kernel based on a vanilla release there may be bug
> fixes that are going to be in the next vanilla release that we can
> apply straight away.

Release cycle of vanilla kernels has become short/acceptable again, so it
should be possible to pick one up inside your timeframe. And yes, there will
always be another bug, so if you go hunting for only the next bugfix, you will
probably be releasing never again.

> 2. Our goals are different from the vanilla kernel.
> 
> Some issues are not critical to the vanilla kernel, e.g., IDE modules
> but are release-critical for us.

You are talking about an additional _feature_. Why don't you try to make it an
accepted and implemented feature in the vanilla kernels? Sure this may take a
bit more time, but the community wins as a whole. I cannot see the point in
_separation_ regarding GPL'ed software.

> 3. Licensing problems.
> 
> This is specific to Debian.  For anything to be included in our release,
> it has to pass the DFSG.  The vanilla kernel does not have this
> restriction so we may need to remove bits before it's suitable for us.

Uh? Do you place licensing restrictions on a GPL'ed kernel??

I really send prayers for the day distros will stop building own kernels for
they only reduce the installed test base for kernels as a whole by splitting it
up in numerous kernel versions...

Regards,
Stephan

