Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUGHOOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUGHOOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUGHOOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 10:14:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:34468 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262873AbUGHOOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 10:14:46 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <20040707122525.X1924@build.pdx.osdl.net>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<20040707202746.1da0568b.davem@redhat.com>
	<buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp>
	<Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
	<20040708111829.GA3449@gondor.apana.org.au>
	<jebriqtzkc.fsf@sykes.suse.de>
	<20040708135611.GA4526@gondor.apana.org.au>
From: Andreas Schwab <schwab@suse.de>
X-Yow: It's 74 degrees, 12 minutes NORTH, and 41 degrees, 3 minutes EAST!!
 Soon, it will be TUESDAY!!
Date: Thu, 08 Jul 2004 16:13:06 +0200
In-Reply-To: <20040708135611.GA4526@gondor.apana.org.au> (Herbert Xu's
 message of "Thu, 8 Jul 2004 23:56:11 +1000")
Message-ID: <je7jtetwnh.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Thu, Jul 08, 2004 at 03:10:11PM +0200, Andreas Schwab wrote:
>> 
>> There is one place where even prototypes won't help, which is varargs
>> functions like execl.  But I don't think the kernel uses functions with
>> execl-like argument lists.
>
> Actually printk is variadic.

There are quite a few other varargs functions in the kernel, but I was
specifically thinking of the use of a null pointer for terminating the
argument list like execl does.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
