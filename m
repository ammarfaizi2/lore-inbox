Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUGHNPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUGHNPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGHNPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:15:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:43744 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264396AbUGHNMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:12:21 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <20040707122525.X1924@build.pdx.osdl.net>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<20040707202746.1da0568b.davem@redhat.com>
	<buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp>
	<Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
	<20040708111829.GA3449@gondor.apana.org.au>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm thinking about DIGITAL READ-OUT systems and
 computer-generated IMAGE FORMATIONS..
Date: Thu, 08 Jul 2004 15:10:11 +0200
In-Reply-To: <20040708111829.GA3449@gondor.apana.org.au> (Herbert Xu's
 message of "Thu, 8 Jul 2004 21:18:29 +1000")
Message-ID: <jebriqtzkc.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> But it is ironic that you call people who use 0 in a pointer context
> K&R-C bigots.  One of the principal reason why NULL exists at all
> is in fact the lack of prototypes in K&R...

There is one place where even prototypes won't help, which is varargs
functions like execl.  But I don't think the kernel uses functions with
execl-like argument lists.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
