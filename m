Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUAFV6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbUAFV6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 16:58:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:5337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264918AbUAFV6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 16:58:54 -0500
Date: Tue, 6 Jan 2004 14:00:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org
Subject: Re: [Linux-fbdev-devel] [PATCH] VT locking
Message-Id: <20040106140002.6806757b.akpm@osdl.org>
In-Reply-To: <1073425440.773.10.camel@gaston>
References: <1073349182.9504.175.camel@gaston>
	<Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
	<1073425440.773.10.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Andrew, the only bits of the kernel/printk.c that are supposed to get
> to your tree are related to is_console_locked() at this point. The
> force_printk_to_btext is a debug tool that allow to route all printk's
> to some early-boot output mecanism, though it would eventually be
> acceptable upstream with Geert's idea of arch_printk...

That's OK, it's just in there for a soak-test at present - this stuff is
quite a long way away, yes?

It's probably just easiest for you to work against current -bk, send me a
single rolled up patch whenever you have new things for people to test. 
When we're happy with it all we can do a bk merge of everything.
