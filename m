Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbUKQQrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUKQQrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUKQQpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:45:55 -0500
Received: from fsmlabs.com ([168.103.115.128]:45451 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262413AbUKQQnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:43:13 -0500
Date: Wed, 17 Nov 2004 09:42:58 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Sumit Pandya <sumit@elitecore.com>
cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: OOPS - APIC or othere?
In-Reply-To: <HGEFKOBCHAIJDIEJLAKDGEMECAAA.sumit@elitecore.com>
Message-ID: <Pine.LNX.4.61.0411170941130.3941@musoma.fsmlabs.com>
References: <HGEFKOBCHAIJDIEJLAKDGEMECAAA.sumit@elitecore.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Sumit Pandya wrote:

> 	At one of our client I faced timer problem in kernel-2.4.26 and I tried to
> fixed with patching "arch/i386/kernel/mpparse.c" file taken from
> patch-2.4.27.
> ...	...	...
> Mikael Pettersson:
>   o i386 and x86_64 ACPI mpparse timer bug
> ...	...	...
> 	After booting up the system now I get OOPS. Did I applied partial patch by
> taking only patch for mpparse.c from the whole buntch? Does it broken
> dependency to some other functionality? I've ACPI support enabled into
> kernel.
> 	Does following Len's patch provide solution to my OOPS?
> ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.26-rc4/200
> 40422153228-irq2.patch
> 
> Here is output of ksymsoops.

Sending bug reports for partially patched kernels isn't easy for us to 
debug, is there no way for you to simply try booting 2.4.27?

Thanks,
	Zwane
