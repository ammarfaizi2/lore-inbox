Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTKGWJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTKGWIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:08:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264504AbTKGRY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 12:24:57 -0500
Date: Fri, 7 Nov 2003 17:24:56 +0000
From: Matthew Wilcox <willy@debian.org>
To: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [DMESG] cpumask_t in action
Message-ID: <20031107172456.GC23754@parcelfarce.linux.theplanet.co.uk>
References: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 09:13:11AM +0100, Sylvain Jeaugey wrote:
> On Thu, 6 Nov 2003, Matthew Wilcox wrote:
> These lines show you the numa topology of your machine (in our case, we 
> have 2 CPUS per domain, and a memory area).
> This is quite a big piece of information about hardware. Even if it is 
> quite long, I think it should be part of the ACPI information.

Yes, but do we need to know it at boot time, or should it be available
in some other way (eg /proc/acpi/srat or something).  I would argue
that is more useful than seeing it in dmesg.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
