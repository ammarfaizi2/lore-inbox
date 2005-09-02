Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVIBJAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVIBJAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 05:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVIBJAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 05:00:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbVIBJAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 05:00:08 -0400
Date: Fri, 2 Sep 2005 02:00:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: empty patch-2.6.13-git? patches on ftp.kernel.org
In-Reply-To: <1125649389.6928.19.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.58.0509020159110.3613@evo.osdl.org>
References: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
 <1125649389.6928.19.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Sep 2005, David Woodhouse wrote:
> 
> 	rm -rf tmp-empty-tree
> 	mkdir -p tmp-empty-tree/.git
> 	cd tmp-empty-tree

Ahh. Please change that to

	rm -rf tmp-empty-tree
	mkdir tmp-empty-tree
	cd tmp-empty-tree
	git-init-db

because otherwise you'll almost certainly hit something else later on..

		Linus
