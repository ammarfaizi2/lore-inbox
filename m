Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbTJOMHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTJOMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:07:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:8467 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262970AbTJOMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:07:15 -0400
Date: Wed, 15 Oct 2003 22:06:59 +1000
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Message-ID: <20031015120659.GA23592@gondor.apana.org.au>
References: <20031015115740.GA23469@gondor.apana.org.au> <20031015120259.GC1077@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015120259.GC1077@suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 02:02:59PM +0200, Jens Axboe wrote:
> 
> Is sg_tablesize guarenteed to be set? Looks like you need a

This doesn't hurt of course.

However, 2.4's merging code assumed that sg_tablesize is always set.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
