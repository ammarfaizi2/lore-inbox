Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUGHN4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUGHN4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUGHN4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:56:21 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:2308 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263429AbUGHN4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:56:20 -0400
Date: Thu, 8 Jul 2004 23:56:11 +1000
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040708135611.GA4526@gondor.apana.org.au>
References: <20040707122525.X1924@build.pdx.osdl.net> <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com> <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org> <20040708111829.GA3449@gondor.apana.org.au> <jebriqtzkc.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jebriqtzkc.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 03:10:11PM +0200, Andreas Schwab wrote:
> 
> There is one place where even prototypes won't help, which is varargs
> functions like execl.  But I don't think the kernel uses functions with
> execl-like argument lists.

Actually printk is variadic.  But gcc will provide warnings if it
sees a mismatch between the format and the arguments.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
