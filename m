Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbTJJQfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTJJQfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:35:22 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:37772 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S263068AbTJJQfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:35:09 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCMCIA CD-ROM does not work
Date: Fri, 10 Oct 2003 18:35:01 +0200
User-Agent: KMail/1.5.4
References: <200310101652.53796.borton@phys.ethz.ch> <20031010170402.E4702@flint.arm.linux.org.uk>
In-Reply-To: <20031010170402.E4702@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101835.03924.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


True, now I will try to compile a kernel with CONFIG_ISA=y.

Let's see...

On Fri, Oct 10, 2003 at 04:52:50PM +0200, Thom Borton wrote:
> Oct 10 09:38:57 grisu kernel: Yenta: CardBus bridge found at 
0000:00:0c.0 [104d:8082]
> Oct 10 09:38:57 grisu kernel: Yenta: ISA IRQ list 00b8, PCI irq9
> Oct 10 09:38:57 grisu kernel: Socket status: 30000086
> Oct 10 09:38:58 grisu cardmgr[411]: watching 1 socket
> Oct 10 09:38:58 grisu cardmgr[412]: starting, version is 3.2.5
> Oct 10 09:39:15 grisu cardmgr[412]: socket 0: Ninja ATA
> Oct 10 09:39:15 grisu kernel: cs: memory probe 0x0c0000-0x0fffff: 
excluding 0xc0000-0xcbfff 0xdc000-0xdffff 0xe8000-0xfffff
> Oct 10 09:39:15 grisu cardmgr[412]: executing: 'modprobe ide-cs'
> Oct 10 09:39:15 grisu kernel: ide-cs: RequestIRQ: Unsupported mode
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You turned off CONFIG_ISA.

-- 
Thom Borton
Switzerland

