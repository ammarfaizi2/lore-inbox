Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUJXXFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUJXXFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJXXFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:05:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:18106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbUJXXEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:04:50 -0400
Date: Sun, 24 Oct 2004 16:04:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.61.0410242126000.17266@scrub.home>
Message-ID: <Pine.LNX.4.58.0410241601260.13209@ppc970.osdl.org>
References: <41752E53.8060103@pobox.com>  <20041019153126.GG18939@work.bitmover.com>
  <41753B99.5090003@pobox.com>  <4d8e3fd304101914332979f86a@mail.gmail.com>
  <20041019213803.GA6994@havoc.gtf.org>  <4d8e3fd3041019145469f03527@mail.gmail.com>
  <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>  <20041023161253.GA17537@work.bitmover.com>
 <4d8e3fd304102403241e5a69a5@mail.gmail.com> <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org>
 <Pine.LNX.4.61.0410242126000.17266@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Oct 2004, Roman Zippel wrote:
> 
> OTOH people often just send patches directly to you without bothering to 
> contact the maintainer.

And sometimes that ends up being becaue the maintainer is unresposive. 

It happens. I'd much rather make that be the _normal_ flow of events than 
have people think that it's something horrible.

>			 There is no system that sends out notifications, 
> if a patch touches file x/y, so that one has a chance to comment on them.

Well, these days there actually _is_. No, it's not per-file, but a 
procmail filter on the patch bots will actually do a lot better than some 
random "notify me on these files", because it can be personalized any 
which way you want..

> One should also add that bk is not the answer to everything, e.g. bk 
> doesn't really help with maintaining separate patches.

Yes. I think the -mm tree and Andrew's (and other peoples) patch-
maintenance ends up being another part of the workflow, "outside" the BK
trees, exactly because of that.

		Linus
