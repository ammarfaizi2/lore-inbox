Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWJWH6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWJWH6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWJWH6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:58:13 -0400
Received: from ozlabs.org ([203.10.76.45]:10668 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751780AbWJWH6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:58:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17724.29679.520994.865570@cargo.ozlabs.ibm.com>
Date: Mon, 23 Oct 2006 17:49:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor fixes to generic do_div
In-Reply-To: <20061020033359.GR2602@parisc-linux.org>
References: <20061020033359.GR2602@parisc-linux.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:

>   * The semantics of do_div() are:
>   *
> - * uint32_t do_div(uint64_t *n, uint32_t base)
> + * uint32_t do_div(uint64_t n, uint32_t base)

... or would be, if n were passed by reference.  If you're going to
change the comment, I think you should say explicitly that n is
changed.

Paul.
