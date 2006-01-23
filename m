Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWAWQpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWAWQpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWAWQpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:45:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932433AbWAWQpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:45:13 -0500
Subject: Re: [PATCH] slab: Adds two missing kmalloc() checks.
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1138034316.10527.2.camel@localhost>
References: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
	 <1138034316.10527.2.camel@localhost>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 17:44:55 +0100
Message-Id: <1138034695.2977.48.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 18:38 +0200, Pekka Enberg wrote:
> Hi,
> 
> On Mon, 2006-01-23 at 13:31 -0200, Luiz Fernando Capitulino wrote:
> >  Adds two missing kmalloc() checks in kmem_cache_init(). The check is worth
> > because if kmalloc() fails we'll have a nice message instead of a OOPS (which
> > will make us look for a bug).
> > 
> >  We're using BUG_ON() so that embedded people can disable it.
> > 
> > Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>
> 
> Looks good to me. Arjan, you had some objections last time around. Are
> you okay with the change?

I still fail to see the point. Has anyone EVER seen these trigger????


