Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSKNM2Z>; Thu, 14 Nov 2002 07:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSKNM2Z>; Thu, 14 Nov 2002 07:28:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59279 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264878AbSKNM2Y>;
	Thu, 14 Nov 2002 07:28:24 -0500
Date: Thu, 14 Nov 2002 13:34:40 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Kevin Brosius <cobra@compuserve.com>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: bk current build failures (xfrm.h / tpqic02.c)
Message-ID: <20021114123440.GK847@suse.de>
References: <3DD2F0FF.D1306F88@compuserve.com> <1037247457.10978.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037247457.10978.2.camel@rth.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13 2002, David S. Miller wrote:
> On Wed, 2002-11-13 at 16:40, Kevin Brosius wrote:
> > net/core/skbuff.c: At top level:
> > include/net/xfrm.h:104: storage size of `lft' isn't known
> > include/net/xfrm.h:112: storage size of `replay' isn't known
> > include/net/xfrm.h:115: storage size of `stats' isn't known
> > include/net/xfrm.h:117: storage size of `curlft' isn't known
> > make[2]: *** [net/core/skbuff.o] Error 1
> 
> Something is wrong with your tree, net/xfrm.h includes linux/xfrm.h
> which declares the layout of said structures the compiler is
> complaining about.

Most likely he is building out of his bk tree and he forgot to bk get
the files again.

-- 
Jens Axboe

