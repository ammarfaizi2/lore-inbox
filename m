Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTJMI1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJMI1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:27:41 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:9857
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261538AbTJMI1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:27:40 -0400
Date: Mon, 13 Oct 2003 04:27:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
In-Reply-To: <Pine.LNX.4.58.0310130001020.29346@student.dei.uc.pt>
Message-ID: <Pine.LNX.4.53.0310130425510.28426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.56.0310122352140.16519@dot.kde.org>
 <Pine.LNX.4.58.0310130001020.29346@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Marcos D. Marado Torres wrote:

> It doesn't compile to me...
> 
> arch/i386/kernel/kernel.o(.text.init+0x59c8): In function `acpi_parse_lapic':
> : undefined reference to `acpi_table_print_madt_entry'
> arch/i386/kernel/kernel.o(.text.init+0x5a38): In function `acpi_parse_lapic_nmi':
> : undefined reference to `acpi_table_print_madt_entry'
> arch/i386/kernel/kernel.o(.text.init+0x5b2e): In function `acpi_boot_init':
> : undefined reference to `acpi_table_init'
> arch/i386/kernel/kernel.o(.text.init+0x5b53): In function `acpi_boot_init':
> : undefined reference to `acpi_table_parse'
> arch/i386/kernel/kernel.o(.text.init+0x5b7e): In function `acpi_boot_init':
> : undefined reference to `acpi_table_parse_madt'
> arch/i386/kernel/kernel.o(.text.init+0x5bb3): In function `acpi_boot_init':
> : undefined reference to `acpi_table_parse_madt'
> arch/i386/kernel/kernel.o(.text.init+0x5bd1): In function `acpi_boot_init':
> : undefined reference to `acpi_table_parse_madt'
> make: *** [vmlinux] Error 1
> 
> Any thoughts on this?

HT box, no full ACPI? You can turn ACPI completely on as a workaround, i 
believe folks are still looking at an elegant way of doing this.

