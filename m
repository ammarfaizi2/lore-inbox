Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUGBUvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUGBUvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUGBUvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 16:51:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6365 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264922AbUGBUvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 16:51:38 -0400
Date: Fri, 2 Jul 2004 22:51:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: limaunion <limaunion@fibertel.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2 build errors...
Message-ID: <20040702205129.GK28324@fs.tum.de>
References: <40DCEFFB.5020605@fibertel.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DCEFFB.5020605@fibertel.com.ar>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 12:39:39AM -0300, limaunion wrote:

>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.text+0xbe14): In function `powernow_acpi_init':
> : undefined reference to `acpi_processor_register_performance'
> arch/i386/kernel/built-in.o(.text+0xbe3b): In function `powernow_acpi_init':
> : undefined reference to `acpi_processor_unregister_performance'
> arch/i386/kernel/built-in.o(.exit.text+0x3b): In function `powernow_exit':
> : undefined reference to `acpi_processor_unregister_performance'
> make: *** [.tmp_vmlinux1] Error 1
> 
> This also happens in 2.6.7-mm1, I'm wondering if this is my fault or 
> something's wrong?

It seems something is/was wrong.

Can you still reproduce it in 2.6.7-mm5?
If yes, please send your .config.

> Thanks in advance!
> JC

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

