Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWIHTGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWIHTGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWIHTGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:06:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbWIHTGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:06:24 -0400
Date: Fri, 8 Sep 2006 12:06:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/2] own header file for struct page.
Message-Id: <20060908120616.db18c4a0.akpm@osdl.org>
In-Reply-To: <20060908183340.GA8421@osiris.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com>
	<20060908094616.48849a7a.akpm@osdl.org>
	<20060908183340.GA8421@osiris.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 20:33:40 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > > +#ifndef CONFIG_DISCONTIGMEM
> > > +/* The array of struct pages - for discontigmem use pgdat->lmem_map */
> > > +extern struct page *mem_map;
> > > +#endif
> > 
> > Am surprised to see this declaration in this file.
> 
> Hmm... first I thought I could add the same declaration to asm-s390/pgtable.h.
> But then deciced against it, since I would just duplicate code.
> Any better idea where to put it?

dunno.  mmzone.h?
