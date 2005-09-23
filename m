Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVIWBB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVIWBB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 21:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVIWBB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 21:01:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751011AbVIWBB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 21:01:26 -0400
Date: Thu, 22 Sep 2005 18:00:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build failure for 2.6.14-rc2-mm1
Message-Id: <20050922180042.6ebab59d.akpm@osdl.org>
In-Reply-To: <43334E69.5040005@bigpond.net.au>
References: <43334E69.5040005@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> The build fails at the link stage with the following output:
> 
>     LD      .tmp_vmlinux1
>  arch/i386/mach-generic/built-in.o(.text+0x1f0): In function 
>  `acpi_madt_oem_check':
>  include2/asm/mach-summit/mach_mpparse.h:49: undefined reference to 
>  `usb_early_handoff'
>  arch/i386/mach-generic/built-in.o(.text+0x2c0): In function `mps_oem_check':
>  include2/asm/mach-summit/mach_mpparse.h:35: undefined reference to 
>  `usb_early_handoff'
>  make[1]: *** [.tmp_vmlinux1] Error 1
>  make: *** [_all] Error 2

You'll need to enable CONFIG_USB.

