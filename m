Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbVCXFdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVCXFdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbVCXFdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:33:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:6375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263037AbVCXFdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:33:44 -0500
Date: Wed, 23 Mar 2005 21:32:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davidm@snapgear.com, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
Message-Id: <20050323213226.1b8010f8.akpm@osdl.org>
In-Reply-To: <42424D52.7070508@pobox.com>
References: <20050315133644.GA25903@beast>
	<20050324042708.GA2806@beast>
	<20050323203856.17d650ec.akpm@osdl.org>
	<42424D52.7070508@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > It neither applies correctly nor compiles in current kernels.  2.6.11 is
>  > very old in kernel time.
> 
>  Hrm.  This is getting pretty lame, if you can't take patches from the 
>  -latest- stable release.  It's pretty easy in BK:
> 
>  	bk clone -ql -rv2.6.11 linux-2.6 rng-2.6.11
>  	cd rng-2.6.11
>  	{ apply patch }
>  	bk pull ../linux-2.6
> 
>  Can you set up something like that?

About thirty patches have gone into random.c since 2.6.11.  But the patch
was easy enough to apply anyway.

And then, it didn't compile.  I don't think bk will fix that.

