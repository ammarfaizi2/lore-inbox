Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272320AbTHSPob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272323AbTHSPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:44:31 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:58554 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S272320AbTHSPo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:44:28 -0400
Subject: Re: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030819152657.GA3059@gtf.org>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC7B@hdsmsx402.hd.intel.com>
	 <1061297641.649.4.camel@chevrolet.hybel>  <20030819152657.GA3059@gtf.org>
Content-Type: text/plain
Message-Id: <1061307873.860.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 17:44:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 19.08.2003 kl. 17.26 skrev Jeff Garzik:
> On Tue, Aug 19, 2003 at 02:54:01PM +0200, Stian Jordet wrote:
> > tir, 19.08.2003 kl. 05.17 skrev Brown, Len:
> > > > So... concrete suggestions?  Overall, IMO, move everything under 
> > > > CONFIG_ACPI, or, make CONFIG_ACPI_BOOT a _peer_ option, whose 
> > > > selection 
> > > > or lackthereof doesn't affect CONFIG_ACPI visibility at all.
> > > 
> > > Simply re-naming CONFIG_ACPI_HT to be CONFIG_ACPI_BOOT might help, as it
> > > would be more clear that it is necessary for the rest of ACPI.  However,
> > > it may not be obvious that it provides the minimal config to enable HT.
> > > 
> > > Re: peers
> > > Unfortunately ACPI doesn't work so well if CONFIG_ACPI_BOOT is left out.
> > > Yes, it's conceivable, but I spent several hours tinkering with it in
> > > search of a "noht" build option, but ditched it b/c it seemed like a
> > > build option very few would use.
> > > 
> > > Re: CONFIG_ACPI is the the master switch, and all other ACPI options
> > > subservient...
> > > If implemented literally, this is sort of a pain, as CONFIG_ACPI appears
> > > all over the code.  However, a dummy config master ACPI config option
> > > could be used to enable the menu that contains all the rest of ACPI...
> > 
> > Btw, (a little off-topic) should I file a bug-report that my motherboard
> > doesn't boot without acpi (never has, not even with 2.4), or should I
> > just smile and be happy because acpi works like a charm? (I already do
> > that :)
> 
> Nah... you are actually a member of the growing number of people with
> computers that require ACPI to boot.  It's something that will become
> more and more common and times goes on.  Nothing really to "fix" in the
> kernel besides turning on ACPI...

Ok, thanks. Just a note, this isn't a new board, it's almost precisely
two years old.

Thanks :)

Regards,
Stian

