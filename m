Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751986AbWJaFaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWJaFaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 00:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWJaFaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 00:30:55 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:11066 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751476AbWJaFay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 00:30:54 -0500
Date: Mon, 30 Oct 2006 21:26:29 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io_apic compile error
Message-Id: <20061030212629.8f9e9499.randy.dunlap@oracle.com>
In-Reply-To: <4546D8AA.30309@perkel.com>
References: <4546CFA2.8000504@perkel.com>
	<20061030203408.ec2ee5ce.randy.dunlap@oracle.com>
	<4546D8AA.30309@perkel.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 21:01:30 -0800 Marc Perkel wrote:

> 
> 
> Randy Dunlap wrote:
> > On Mon, 30 Oct 2006 20:22:58 -0800 Marc Perkel wrote:
> >
> >   
> >> getting a compile error when compiling 2.6.19rc3. Thought someone might want to fix this.
> >>
> >>   CC      arch/x86_64/kernel/io_apic.o
> >> arch/x86_64/kernel/io_apic.c: In function 'ioapic_pirq_setup':
> >> arch/x86_64/kernel/io_apic.c:412: error: 'MAX_PIRQS' undeclared (first use in this function)
> >> arch/x86_64/kernel/io_apic.c:412: error: (Each undeclared identifier is reported only once
> >> arch/x86_64/kernel/io_apic.c:412: error: for each function it appears in.)
> >> arch/x86_64/kernel/io_apic.c:417: error: 'pirq_entries' undeclared (first use in this function)
> >> arch/x86_64/kernel/io_apic.c:419: error: 'pirqs_enabled' undeclared (first use in this function)
> >> arch/x86_64/kernel/io_apic.c:412: warning: unused variable 'ints'
> >> make[1]: *** [arch/x86_64/kernel/io_apic.o] Error 1
> >> make: *** [arch/x86_64/kernel] Error 2
> >>     
> >
> > Hm, it builds for me.  Please post your .config file.
> >
> >
> >   
> ok - here it is
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.19-rc3
> # Mon Oct 30 20:20:25 2006

Odd.  That .config builds fine for me too.

Is this a unmodified 2.6.19-rc3?  How did you get it?

Maybe someone else can discover the problem.

---
~Randy
