Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWHBGWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWHBGWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWHBGWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:22:43 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:10895 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751268AbWHBGWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:22:42 -0400
Date: Wed, 2 Aug 2006 08:23:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060802062309.GH20108@suse.de>
References: <20060801072315.GH31908@suse.de> <E1G83hL-00035h-00@gondolin.me.apana.org.au> <20060801233221.GA11913@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801233221.GA11913@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02 2006, Herbert Xu wrote:
> On Wed, Aug 02, 2006 at 09:30:51AM +1000, Herbert Xu wrote:
> > 
> > OK, I used a WARN_ON mainly because ext3 has been doing this for years
> > without killing anyone until now :)
> > 
> > [BLOCK] bh: Ensure bh fits within a page
> 
> Actually, the other reason is that we can't BUG_ON until ext3 is fixed
> to not do this.  So I suppose we should keep the WARN_ON until that
> happens.

Yep, the ext3 bits need to go in first.

-- 
Jens Axboe

