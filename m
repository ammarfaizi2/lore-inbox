Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUJXB0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUJXB0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 21:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUJXB0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 21:26:40 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:12261 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261352AbUJXB0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 21:26:33 -0400
Date: Sun, 24 Oct 2004 10:26:15 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: fixed compile error
Message-Id: <20041024102616.50dee9f7.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20041023170505.GA17110@linux-mips.org>
References: <20041024010659.2c4a3f1e.yuasa@hh.iij4u.or.jp>
	<20041023170505.GA17110@linux-mips.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 19:05:05 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sun, Oct 24, 2004 at 01:06:59AM +0900, Yoichi Yuasa wrote:
> 
> > This patch had fixed "causes a section type conflict".
> > 
> > ex.
> > arch/mips/pci/fixup-mpc30x.c:32: error: irq_tab_mpc30x causes a section type conflict
> 
> This is bogus.

Thank you for your comment.
Which is the right way of fixing this problem?

I'm using following toolchain.

$ mipsel-linux-gcc -v
Reading specs from /usr/local/lib/gcc-lib/mipsel-linux/3.3.2/specs
Configured with: ../gcc-3.3.2/configure --target=mipsel-linux --enable-languages=c --disable-shared --with-headers=/usr/mipsel-linux/include --with-libs=/usr/mipsel-linux/lib
Thread model: posix
gcc version 3.3.2
$ mipsel-linux-ld -v
GNU ld version 2.14.90.0.8 20040114

Yoichi
