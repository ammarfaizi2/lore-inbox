Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312982AbSDYH3F>; Thu, 25 Apr 2002 03:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDYH3E>; Thu, 25 Apr 2002 03:29:04 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:6298 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S312982AbSDYH3D>;
	Thu, 25 Apr 2002 03:29:03 -0400
Date: Thu, 25 Apr 2002 08:26:01 +0100
Message-Id: <200204250726.g3P7Q1e14638@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Eric Sandeen <sandeen@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (repost) kmem_cache_zalloc
In-Reply-To: <1019682472.15455.33.camel@stout.americas.sgi.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1019682472.15455.33.camel@stout.americas.sgi.com> you wrote:
> We'd like to incorporate this into the kernel proper, and several others
> chimed in that it would be useful, so here's the patch.  If it's a no-go
> with Linus, we can roll this functionality back under fs/xfs to reduce
> our changes in the mainline kernel.

personally I liked the kcalloc suggesition more; that would fix a lot of
multiplication exploitable bugs at the same time
