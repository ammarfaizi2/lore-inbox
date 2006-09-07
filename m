Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWIGEiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWIGEiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 00:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWIGEiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 00:38:10 -0400
Received: from xenotime.net ([66.160.160.81]:41379 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161073AbWIGEiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 00:38:09 -0400
Date: Wed, 6 Sep 2006 21:41:45 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [-mm patch] ACPI_SONY shouldn't default m
Message-Id: <20060906214145.95403569.rdunlap@xenotime.net>
In-Reply-To: <20060906203003.95ad130a.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060906230700.GE12157@stusta.de>
	<20060906203003.95ad130a.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006 20:30:03 -0700 Andrew Morton wrote:

> On Thu, 7 Sep 2006 01:07:00 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Drivers should default to n.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig.old	2006-09-07 00:49:37.000000000 +0200
> > +++ linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig	2006-09-07 00:50:01.000000000 +0200
> > @@ -251,7 +251,6 @@
> >  config ACPI_SONY
> >  	tristate "Sony Laptop Extras"
> >  	depends on X86 && ACPI
> > -	default m
> 
> Not this one - I need it on my Vaio and I get sick of the option vanishing.
> Make it depend on CONFIG_AKPM?

I'll ack that one.  :)
otherwise I also agree with Adrian's patch...

---
~Randy
