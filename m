Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267873AbUBRSzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267874AbUBRSzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:55:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:50858 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267873AbUBRSzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:55:02 -0500
Date: Wed, 18 Feb 2004 10:55:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: ramon.rey@hispalinux.es
Cc: rrey@ranty.pantax.net, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>
Subject: Re: 2.6.3-mm1
Message-Id: <20040218105555.17cc7bba.akpm@osdl.org>
In-Reply-To: <1077114386.12206.2.camel@debian>
References: <20040217232130.61667965.akpm@osdl.org>
	<1077114386.12206.2.camel@debian>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon Rey Vicente <rrey@ranty.pantax.net> wrote:
>
> Hi,
> 
> With ACPI disabled and APM enabled I get this build error.
> 
> arch/i386/kernel/built-in.o(.text+0xbf3a): In function `acpi_apic_setup':
> : undefined reference to `smp_found_config'
> arch/i386/kernel/built-in.o(.text+0xbf43): In function `acpi_apic_setup':
> : undefined reference to `clustered_apic_check'
> make: *** [.tmp_vmlinux1] Error 1

The fickle finger of fate points at expanded-pci-config-space.patch

