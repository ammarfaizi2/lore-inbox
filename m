Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTKGXhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKGWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:29 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:2727 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263935AbTKGIP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 03:15:57 -0500
Date: Fri, 7 Nov 2003 09:13:11 +0100 (CET)
From: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
X-X-Sender: sylvain@localhost.localdomain
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org, <linux-ia64@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
Subject: Re: [DMESG] cpumask_t in action
In-Reply-To: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/11/2003 09:19:54,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/11/2003 09:19:59,
	Serialize complete at 07/11/2003 09:19:59
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Matthew Wilcox wrote:

> > ACPI: SRAT Processor (id[0x00] eid[0x00]) in proximity domain 0 enabled
> > ACPI: SRAT Processor (id[0x20] eid[0x00]) in proximity domain 0 enabled
[...]
> > ACPI: SRAT Processor (id[0x00] eid[0x5e]) in proximity domain 47 enabled
> > ACPI: SRAT Processor (id[0x20] eid[0x5e]) in proximity domain 47 enabled
> 
> ... for example ;-)  96 lines which honestly tell me nothing.
> 
> > ACPI: SRAT Memory (0x0000003000000000 length 0x0000001000000000 type 0x1) in proximity domain 0 enabled
> > ACPI: SRAT Memory (0x000000b000000000 length 0x0000001000000000 type 0x1) in proximity domain 1 enabled
> [ snip 44 lines ]
> > ACPI: SRAT Memory (0x0000173000000000 length 0x0000001000000000 type 0x1) in proximity domain 46 enabled
> > ACPI: SRAT Memory (0x000017b000000000 length 0x0000001000000000 type 0x1) in proximity domain 47 enabled
> 
> ... and again.
> 
These lines show you the numa topology of your machine (in our case, we 
have 2 CPUS per domain, and a memory area).
This is quite a big piece of information about hardware. Even if it is 
quite long, I think it should be part of the ACPI information.

Sylvain

