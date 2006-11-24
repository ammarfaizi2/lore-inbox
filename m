Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935103AbWKXXOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935103AbWKXXOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 18:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966261AbWKXXOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 18:14:51 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:26587 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S935103AbWKXXOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 18:14:50 -0500
Date: Fri, 24 Nov 2006 18:11:12 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
Subject: Re: + uml-make-execvp-safe-for-our-usage.patch added to -mm tree
Message-ID: <20061124231112.GA5781@ccure.user-mode-linux.org>
References: <200610180014.k9I0EZ1J012332@shell0.pdx.osdl.net> <20061124195011.GB4745@ccure.user-mode-linux.org> <20061124134621.be9835e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124134621.be9835e7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 01:46:21PM -0800, Andrew Morton wrote:
> OK.  Is it needed for 2.6.19?

It fixes bugs, so I would say yes.

> Also, I'm still sitting on the below.  I have a note that you nacked it,
> but I forget why.

I nacked it mostly based on the changelog, which turned out to be
incorrect.  The substance of the change I think is OK, except that it
looks like stddef (according to the C standard - 4.1.5) , not
linux/types is the official way to get size_t.   I'll send a follow-up
patch to fix that.

I would hold this patch until after 2.6.19.

				Jeff
-- 
Work email - jdike at linux dot intel dot com
