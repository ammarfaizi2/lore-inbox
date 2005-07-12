Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVGLMQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVGLMQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVGLMNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:13:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261376AbVGLMMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:12:25 -0400
Date: Tue, 12 Jul 2005 14:12:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2
Message-ID: <20050712121224.GA4034@stusta.de>
References: <20050712021724.13b2297a.akpm@osdl.org> <20050712110505.GF28243@stusta.de> <1121169709.27264.146.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121169709.27264.146.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 01:01:48PM +0100, David Woodhouse wrote:
> On Tue, 2005-07-12 at 13:05 +0200, Adrian Bunk wrote:
> > Although it's not mentioned in the changelog, it seems the MTD GIT
> > tree was dropped.
> > 
> > I noticed this because a compile error that was fixed in -mm1 is back.
> 
> What error? The MTD GIT tree is presumably absent from -mm because it
> was pulled into Linus' tree last night.

<--  snip  -->

...
  CC      drivers/mtd/chips/cfi_probe.o
In file included from drivers/mtd/chips/cfi_probe.c:18:
include/linux/mtd/xip.h:68:25: error: asm/mtd-xip.h: No such file or directory
include/linux/mtd/xip.h:72:2: warning: #warning "missing IRQ and timer primitives for XIP MTD support"
include/linux/mtd/xip.h:73:2: warning: #warning "some of the XIP MTD support code will be disabled"
include/linux/mtd/xip.h:74:2: warning: #warning "your system will therefore be unresponsive when writing or erasing flash"
{standard input}: Assembler messages:
{standard input}:5: Warning: ignoring changed section attributes for .data
make[3]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
...

<--  snip  -->

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

