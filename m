Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTITXFb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 19:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTITXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 19:05:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:26783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261626AbTITXF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 19:05:29 -0400
Date: Sat, 20 Sep 2003 16:06:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move some more intilization out of drivers/char/mem.c
Message-Id: <20030920160645.30c2745d.akpm@osdl.org>
In-Reply-To: <20030920132900.GC23153@lst.de>
References: <20030920132900.GC23153@lst.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> keeping init order the same..

drivers/char/random.c:1497: warning: static declaration for `rand_initialize' follows non-static
drivers/char/random.c:1519: warning: initialization from incompatible pointer type
drivers/char/tty_io.c:2427: warning: static declaration for `tty_init' follows non-static
drivers/char/tty_io.c:2516: warning: initialization from incompatible pointer type
drivers/char/misc.c:281: warning: static declaration for `misc_init' follows non-static

Please compile-test things...

