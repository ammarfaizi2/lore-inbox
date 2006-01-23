Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWAWQik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWAWQik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWAWQik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:38:40 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:13245 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932433AbWAWQij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:38:39 -0500
Subject: Re: [PATCH] slab: Adds two missing kmalloc() checks.
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       arjan@infradead.org
In-Reply-To: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
References: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
Date: Mon, 23 Jan 2006 18:38:36 +0200
Message-Id: <1138034316.10527.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-01-23 at 13:31 -0200, Luiz Fernando Capitulino wrote:
>  Adds two missing kmalloc() checks in kmem_cache_init(). The check is worth
> because if kmalloc() fails we'll have a nice message instead of a OOPS (which
> will make us look for a bug).
> 
>  We're using BUG_ON() so that embedded people can disable it.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

Looks good to me. Arjan, you had some objections last time around. Are
you okay with the change?

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

			Pekka

