Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTHTDVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 23:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbTHTDVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 23:21:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:32929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261588AbTHTDVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 23:21:45 -0400
Date: Tue, 19 Aug 2003 20:23:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jonathan Brown <jbrown@emergence.uk.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@intel.com
Subject: Re: 2.6.0-test3-mm3
Message-Id: <20030819202329.24e938ac.akpm@osdl.org>
In-Reply-To: <1061349342.8327.11.camel@localhost>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<1061349342.8327.11.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Brown <jbrown@emergence.uk.net> wrote:
>
>   CC      arch/i386/kernel/mpparse.o
> arch/i386/kernel/mpparse.c: In function `mp_config_ioapic_for_sci':
> arch/i386/kernel/mpparse.c:1067: warning: implicit declaration of
> function `mp_find_ioapic'
> arch/i386/kernel/mpparse.c:1069: `mp_ioapic_routing' undeclared (first
> use in this function)
> arch/i386/kernel/mpparse.c:1069: (Each undeclared identifier is reported
> only once
> arch/i386/kernel/mpparse.c:1069: for each function it appears in.)
> arch/i386/kernel/mpparse.c:1071: warning: implicit declaration of
> function `io_apic_set_pci_routing'
> arch/i386/kernel/mpparse.c: In function `mp_parse_prt':
> arch/i386/kernel/mpparse.c:1115: `mp_ioapic_routing' undeclared (first
> use in this function)
> make[1]: *** [arch/i386/kernel/mpparse.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 

Please send your .config to linux-acpi@intel.com and the fine folks
there will fix it up, thanks.

