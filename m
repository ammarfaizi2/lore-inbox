Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUJBQzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUJBQzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUJBQzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:55:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55044 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267375AbUJBQzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:55:17 -0400
Date: Sat, 2 Oct 2004 18:54:41 +0200
From: Adrian Bunk <adrian.bunk@stusta.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: Tim Cambrant <cambrant@acc.umu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-ID: <20041002165441.GE2470@stusta.mhn.de>
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <20041002105038.GB2470@stusta.mhn.de> <20041002105853.GD11386@shaka.acc.umu.se> <415EA6C0.9020008@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415EA6C0.9020008@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 09:01:52AM -0400, Ed Sweetman wrote:
>...
> asm/io_apic.h is the file that seems to be missing all the 
> declarations.  When i included it in irq.c as the above patch does, my 
> build immediately failed with this.   My config is for uni-processor 
> with io-apic enabled in config.
> 
> In file included from arch/i386/kernel/irq.c:20:
> include/asm/io_apic.h: At top level:
> include/asm/io_apic.h:108: error: `MAX_IO_APICS' undeclared here (not in 
> a function)
>...
> make[1]: *** [arch/i386/kernel/irq.o] Error 1

Please send your .config .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

