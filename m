Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318262AbSHKKai>; Sun, 11 Aug 2002 06:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSHKKah>; Sun, 11 Aug 2002 06:30:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12293 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318262AbSHKKah>; Sun, 11 Aug 2002 06:30:37 -0400
Date: Sun, 11 Aug 2002 11:34:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Ivan Gyurdiev <ivangurdiev@attbi.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.31
Message-ID: <20020811113418.A29786@flint.arm.linux.org.uk>
References: <200208100551.46142.ivangurdiev@attbi.com.suse.lists.linux.kernel> <p73r8h5itu7.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73r8h5itu7.fsf@oldwotan.suse.de>; from ak@suse.de on Sun, Aug 11, 2002 at 12:16:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:16:16PM +0200, Andi Kleen wrote:
> Ivan Gyurdiev <ivangurdiev@attbi.com> writes:
> > 
> > drivers/built-in.o: In function `parport_pc_probe_port':
> > drivers/built-in.o(.text+0x2dbf6): undefined reference to `request_dma'
> > drivers/built-in.o(.text+0x2dc98): undefined reference to `free_dma'
> > drivers/built-in.o: In function `parport_pc_unregister_port':
> > drivers/built-in.o(.text+0x2df94): undefined reference to `free_dma'
> > drivers/built-in.o(.data+0x4c20): undefined reference to `request_dma'
> > drivers/built-in.o(.data+0x4c24): undefined reference to `free_dma'
> > make: *** [vmlinux] Error 1
> 
> make oldconfig and recompiling should fix that.

Hmm, is it time to make .config depend on arch/$(ARCH)/config.in and all
Config.in files?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

