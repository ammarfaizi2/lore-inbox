Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWGPIUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWGPIUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 04:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWGPIUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 04:20:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750703AbWGPIUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 04:20:47 -0400
Date: Sun, 16 Jul 2006 04:20:28 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: dwmw2@infradead.org, arjan@infradead.org, maillist@jg555.com,
       ralf@linux-mips.org, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060716082027.GX32572@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 05:09:28PM -0400, Albert Cahalan wrote:
> Here we have a full-featured set of atomic ops, byte swapping
> with readable names and a distinction for pointers, nice macros
> for efficient data structure manipulation...

And userland has GCC __sync_* atomic builtins, <byteswap.h>, etc.
That stuff works in userspace, unlike most of the stuff provided by kernel
headers.

	Jakub
