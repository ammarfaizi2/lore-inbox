Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266639AbUGQHrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUGQHrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 03:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUGQHrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 03:47:37 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:38873 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S266639AbUGQHrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 03:47:36 -0400
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior
	2.6.7/-mm1
From: Dax Kelson <dax@gurulabs.com>
To: Len Brown <len.brown@intel.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-thinkpad@linux-thinkpad.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1090048541.2792.26.camel@dhcppc4>
References: <566B962EB122634D86E6EE29E83DD808182C04EC@hdsmsx403.hd.intel.com>
	 <1090048541.2792.26.camel@dhcppc4>
Content-Type: text/plain
Message-Id: <1090050469.5571.34.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 17 Jul 2004 01:47:49 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-17 at 01:15, Len Brown wrote:
> On Thu, 2004-07-15 at 17:57, Florian Weimer wrote:
> > * David Weinehall:
> > 
> > > Strange.  suspend works for me (T40 though, not T40p), latest
> > > BIOS-version, ACPI enabled, APM disabled.
...
> > I wonder why the system has got such a high affinity to IRQ 11.  I've
> > never seen so much IRQ sharing before. 8-/
> 
> Only the BIOS knows why -- Linux doesn't move IRQs around in PIC mode.
> But you can make it attempt to balance them with "acpi_irq_balance" if
> you're feeling adventerous.

On my T42p, my factory default BIOS settings are to put everything on
IRQ 11.

Strange, but true.

Dax Kelson

