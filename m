Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUBTSFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUBTSFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:05:30 -0500
Received: from shockwave.systems.pipex.net ([62.241.160.9]:40412 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261360AbUBTSFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:05:19 -0500
Message-ID: <40364C5D.1000505@emergence.uk.net>
Date: Fri, 20 Feb 2004 18:05:17 +0000
From: Jonathan Brown <jbrown@emergence.uk.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Boler <j.m.boler@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1 compile error
References: <40364BE3.2000002@sms.ed.ac.uk>
In-Reply-To: <40364BE3.2000002@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm1 is really broken - use mm2 instead

Jonathan Boler wrote:
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.text+0xcd46): In function `acpi_apic_setup':
> : undefined reference to `smp_found_config'
> arch/i386/kernel/built-in.o(.text+0xcd4f): In function `acpi_apic_setup':
> : undefined reference to `clustered_apic_check'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> If I enable APIC the error goes away.
> 
> I have a Dell laptop with a broken bios so the APIC doesn't enable so I 
> leave it disabled in .config.
> 
> My .config is attached.
> 
> Jonathan
