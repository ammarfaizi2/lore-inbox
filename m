Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTKGXCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKGWYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:24:25 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:21508 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264087AbTKGL2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:28:39 -0500
Date: Fri, 7 Nov 2003 22:28:33 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031107112833.GA5239@gondor.apana.org.au>
References: <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de> <20031106210900.GA29000@gondor.apana.org.au> <20031107112346.GA5153@gondor.apana.org.au> <20031107112555.GC591@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107112555.GC591@suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 12:25:55PM +0100, Jens Axboe wrote:
> 
> Could be related, someone is doing an unlock on an already unlocked
> page. Is this the same system that saw the bounce problem initially?

Yes, see http://bugs.debian.org/218566 for details.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
