Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUFOGhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUFOGhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbUFOGhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:37:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29336 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265313AbUFOGhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:37:52 -0400
Date: Tue, 15 Jun 2004 08:37:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040615063745.GC25903@suse.de>
References: <20040603015356.709813e9.akpm@osdl.org> <20040603152042.GK1946@suse.de> <1086921637.2242.471.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086921637.2242.471.camel@dhcppc4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 2004, Len Brown wrote:
> On Thu, 2004-06-03 at 11:20, Jens Axboe wrote:
> > On Thu, Jun 03 2004, Andrew Morton wrote:
> > >  bk-acpi.patch
> > 
> > Doesn't compile if you disable ACPI, since mp_register_gsi is guarded by
> > 
> > #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
> > 
> > but used in arch/i386/kernel/acpi/boot.c if CONFIG_X86_IO_APIC is set
> > alone. I have to disable ACPI on this box still, otherwise it crashes
> > very hard immediately after displaying ACPI banner.
> 
> "Crashes very hard" I would like to know more.
> Does the box have an IOAPIC?
> If no, does it boot with "nolapic"?

I think you already know all the details, I discussed it with you some
weeks ago :-). Let me know if you don't have the thread, and I'll bounce
it to you.

I'll try nolapic, haven't tried that.

> If yes, does this patch help? 
> http://bugme.osdl.org/show_bug.cgi?id=1269

Will check, thanks.

-- 
Jens Axboe

