Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTJMKi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTJMKi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:38:56 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:10427 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261332AbTJMKiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:38:54 -0400
Date: Mon, 13 Oct 2003 11:38:18 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
In-Reply-To: <Pine.LNX.4.53.0310130425510.28426@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0310131136410.24397@student.dei.uc.pt>
References: <Pine.LNX.4.56.0310122352140.16519@dot.kde.org>
 <Pine.LNX.4.58.0310130001020.29346@student.dei.uc.pt>
 <Pine.LNX.4.53.0310130425510.28426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Zwane Mwaikambo wrote:

> On Mon, 13 Oct 2003, Marcos D. Marado Torres wrote:
>
> > It doesn't compile to me...
> >
> > arch/i386/kernel/kernel.o(.text.init+0x59c8): In function `acpi_parse_lapic':
> > : undefined reference to `acpi_table_print_madt_entry'
> > arch/i386/kernel/kernel.o(.text.init+0x5a38): In function `acpi_parse_lapic_nmi':
> > : undefined reference to `acpi_table_print_madt_entry'
> > arch/i386/kernel/kernel.o(.text.init+0x5b2e): In function `acpi_boot_init':
> > : undefined reference to `acpi_table_init'
> > arch/i386/kernel/kernel.o(.text.init+0x5b53): In function `acpi_boot_init':
> > : undefined reference to `acpi_table_parse'
> > arch/i386/kernel/kernel.o(.text.init+0x5b7e): In function `acpi_boot_init':
> > : undefined reference to `acpi_table_parse_madt'
> > arch/i386/kernel/kernel.o(.text.init+0x5bb3): In function `acpi_boot_init':
> > : undefined reference to `acpi_table_parse_madt'
> > arch/i386/kernel/kernel.o(.text.init+0x5bd1): In function `acpi_boot_init':
> > : undefined reference to `acpi_table_parse_madt'
> > make: *** [vmlinux] Error 1
> >
> > Any thoughts on this?
>
> HT box, no full ACPI? You can turn ACPI completely on as a workaround, i
> believe folks are still looking at an elegant way of doing this.

Strange is that I don't have nothing about ACPI selected in the .config ...
And I can't, since it doesn't support my ASUS M3N Laptop.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Best regards,
Mind Booster Noori

--
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

