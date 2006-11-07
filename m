Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753381AbWKGVf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbWKGVf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbWKGVf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:35:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753381AbWKGVfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:35:25 -0500
Date: Tue, 7 Nov 2006 13:35:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 0/1] mspec driver: compile error
Message-Id: <20061107133512.a49b11e0.akpm@osdl.org>
In-Reply-To: <4550609A.7010908@sgi.com>
References: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>
	<4550609A.7010908@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2006 11:31:54 +0100
Jes Sorensen <jes@sgi.com> wrote:

> Fix MSPEC driver to build for non SN2 enabled configs as the driver
> should work in cached and uncached modes (no fetchop) on these systems.
> In addition make MSPEC select IA64_UNCACHED_ALLOCATOR, which is required
> for it.

i386 `make allmodconfig' says:

drivers/char/Kconfig:425:warning: 'select' used by config symbol 'MSPEC' refer to undefined symbol 'IA64_UNCACHED_ALLOCATOR'
