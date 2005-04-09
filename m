Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVDIKIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVDIKIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 06:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVDIKID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 06:08:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:46864 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261327AbVDIKIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 06:08:00 -0400
Date: Sat, 9 Apr 2005 20:07:02 +1000
To: Magnus Damm <magnus.damm@gmail.com>
Cc: rddunlap@osdl.org, linux-os@analogic.com, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
Message-ID: <20050409100702.GA6148@gondor.apana.org.au>
References: <aec7e5c305040711535bbe07d3@mail.gmail.com> <E1DK4zA-0005rr-00@gondolin.me.apana.org.au> <aec7e5c3050409024365d724dd@mail.gmail.com> <20050409094814.GA5953@gondor.apana.org.au> <aec7e5c30504090303790ff7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30504090303790ff7a7@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 12:03:45PM +0200, Magnus Damm wrote:
>
> > Perhaps they should start using initramfs then.
> 
> But how does that help me? I still want to be able to pass a list of
> unwanted modules on the kernel command line. Using initramfs and
> modules is fine, although I would prefer being able to unload built-in
> modules instead - but that is another story. Your suggestion just
> pushes the problem to user space. I think the best alternative would

Well you know what they say:

If it can be done in user space, then do it in user space.

Once the drivers are put on the initramfs it is trivial to add code that
disables them based on boot-time options.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
