Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVAQGH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVAQGH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 01:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVAQGH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 01:07:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47366 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262703AbVAQGHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 01:07:51 -0500
Date: Mon, 17 Jan 2005 07:07:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64: kill stale mtrr_centaur_report_mcr
Message-ID: <20050117060746.GW4274@stusta.de>
References: <20050116074817.GX4274@stusta.de> <20050117055040.GE19187@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117055040.GE19187@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 06:50:40AM +0100, Andi Kleen wrote:
> On Sun, Jan 16, 2005 at 08:48:17AM +0100, Adrian Bunk wrote:
> > I didn't know the x86_64 port supports the Centaur CPU.  ;-)
> 
> Have you actually compiled this? Most of the gunk in asm-x86_64/mtrr.h
> is because we share the MTRR driver with i386, and there is no good
> way to disable specific CPUs in there.

If X86_64 wouldn't have hijyacked CONFIG_X86, you could simply put 
obj-$(CONFIG_X86) there...

I haven't tried to compile it, but OTOH I haven't yet found which dirty 
tricks you are using for compiling arch/i386/kernel/cpu/centaur.c on
x86_64...

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

