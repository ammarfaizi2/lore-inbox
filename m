Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHRCxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHRCxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 22:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWHRCxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 22:53:52 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:59405 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932333AbWHRCxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 22:53:52 -0400
Date: Fri, 18 Aug 2006 12:53:02 +1000
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060818025302.GA23144@gondor.apana.org.au>
References: <E1G83hL-00035h-00@gondolin.me.apana.org.au> <1155856456.18864.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155856456.18864.5.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 04:14:16PM -0700, Badari Pulavarty wrote:
> 
> Wondering, if there is any special thing I need to do to reproduce
> the problem ? Please let me know.

I must say that I didn't try to reproduce the problem.  However,
here is the bugzilla entry for it.  It apparently shows up during
installation:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200127

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
