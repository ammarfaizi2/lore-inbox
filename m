Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbTIKBhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbTIKBhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:37:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:1003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265774AbTIKBhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:37:06 -0400
Date: Wed, 10 Sep 2003 18:36:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Message-ID: <20030910183655.H9800@osdlab.pdx.osdl.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F592AA7.7020700@pobox.com> <20030905190338.W16228@osdlab.pdx.osdl.net> <200309061332.39489.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309061332.39489.adq_dvb@lidskialf.net>; from adq_dvb@lidskialf.net on Sat, Sep 06, 2003 at 01:32:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew de Quincey (adq_dvb@lidskialf.net) wrote:
> On Saturday 06 September 2003 03:03, Chris Wright wrote:
> > You'll find dmesg and interrupts from pci=noacpi, acpi=off, disassembled
> > dsdt and dmidecode.  Don't have the failed boot dmesg yet.  I ported
> > netconsole to my eth driver, but it's not yet working.
> 
> Cool, ta.. I'll have a look, but I'll probably need the failed dmesg to make 
> any real progress.

Sorry, for the delay.  I captured console output from failed (normal
acpi) boot.  I also re-ran on 2.6.0-test5 and captured those outputs.
The test3-bk3 is actually test3-bk2+acpi_>15_irq.patch which is the
patch that began the breakage for me.

http://developer.osdl.org/chrisw/acpi/2.6.0-test3-bk3/
http://developer.osdl.org/chrisw/acpi/2.6.0-test5/

Each have dmesg and interrupts from pci=noacpi and acpi=off, dmesg with
acpi enabled, disassembled dsdt, and dmidecode.

Let me know if you need any more info.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
