Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWEPTtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWEPTtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWEPTtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:49:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39435 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750800AbWEPTtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:49:23 -0400
Date: Mon, 8 May 2006 23:47:23 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: marekw1977@yahoo.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acpi4asus
Message-ID: <20060508234723.GB4349@ucw.cz>
References: <20060511130743.GG15876@mail.muni.cz> <20060511073211.1da40329.akpm@osdl.org> <200605121116.11930.marekw1977@yahoo.com.au> <44649A2E.4070803@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44649A2E.4070803@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I am far from qualified to comment on this, but from a 
> >users point of view, is it possible to not have laptop 
> >specific code in the kernel?
> >I have had two Linux laptops and with both I had ACPI 
> >issues.
> >The vendors of both laptops (Toshiba Tecra S1 and now 
> >an Asus W3V) don't seem to be following standards. With 
> >both I seem to need to patch ACPI to get various 
> >functions of the laptop to work.
> >I would love to see laptop specific functionality 
> >definitions exist outside the kernel.
> >
> I don't think that forcing laptop users to have their 
> own code outside the kernel is really the best approach 
> for either the developers or the users. Most users will 

No, we don't want that. But we do not want ibm-acpi, toshiba-acpi,
asus-acpi, etc, when they really only differ in string constants used.

We want userland to tell kernel 'mail led is controlled by AML routine
foo', instead of having gazillion *-acpi modules.


-- 
Thanks for all the (sleeping) penguins.
