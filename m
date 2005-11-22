Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVKVOUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVKVOUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVKVOUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:20:11 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:27792 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964948AbVKVOUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:20:10 -0500
Date: Tue, 22 Nov 2005 07:20:09 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/5] Ensure NO_IRQ is appropriately defined on all architectures
Message-ID: <20051122142009.GL1598@parisc-linux.org>
References: <E1EeQYc-00055n-Gc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EeQYc-00055n-Gc@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 12:19:06AM -0500, Matthew Wilcox wrote:
> Add a default definition of NO_IRQ to <linux/hardirq.h> and make the
> definition in <asm/hardirq.h> uniform across all architectures which
> define it.

I don't like this patch in the cold light of day, since I made the
include mess worse than it already is.  Updated patch to follow.
