Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTBSViT>; Wed, 19 Feb 2003 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTBSViT>; Wed, 19 Feb 2003 16:38:19 -0500
Received: from havoc.daloft.com ([64.213.145.173]:9095 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261868AbTBSViS>;
	Wed, 19 Feb 2003 16:38:18 -0500
Date: Wed, 19 Feb 2003 16:48:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Ion Badulescu <ionut@badula.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
Message-ID: <20030219214817.GD4977@gtf.org>
References: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com> <20030219092046.458c2876.rddunlap@osdl.org> <1045692372.14268.9.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045692372.14268.9.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 02:06:12PM -0800, David S. Miller wrote:
> On Wed, 2003-02-19 at 09:20, Randy.Dunlap wrote:
> > Does this help with being able to printk() a <dma_addr_t>?  How?
> > Always use a cast to (u64) or something else?
> 
> One should always cast to long long and use %llx.  There is no
> printf format appropriate for a 'u64'.

/me wishes gcc would let the user application define printf formats
for arbitrary [non-struct] user data types...

	Jeff



