Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTKEJt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 04:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTKEJt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 04:49:59 -0500
Received: from ns.suse.de ([195.135.220.2]:18318 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262761AbTKEJt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 04:49:59 -0500
Date: Wed, 5 Nov 2003 10:48:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031105094855.GD1477@suse.de>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104090353.GM1477@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04 2003, Jens Axboe wrote:
> > I think it should be safe though as recount is not always called (it is
> > only called if the phys/hw segments exceed the limits).  In the cases
> > where it is not called you may be looking at an overestimate anyway.
> 
> I think it is safe too, just want to make absolutely sure.

I don't see any problems with this approach, I'll commit the code.
Thanks!

-- 
Jens Axboe

