Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbTHVP10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbTHVP10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:27:26 -0400
Received: from havoc.gtf.org ([63.247.75.124]:60332 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263327AbTHVP1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:27:21 -0400
Date: Fri, 22 Aug 2003 11:27:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] noapic should depend on ioapic config not local
Message-ID: <20030822152720.GA31693@gtf.org>
References: <20030821052140.GA19039@gtf.org> <20030822110920.B639@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822110920.B639@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 11:09:20AM +0200, Ingo Oeser wrote:
> On Thu, Aug 21, 2003 at 01:21:40AM -0400, Jeff Garzik wrote:
> > Zwane's comment was correct, it needs to be CONFIG_X86_IO_APIC.
> 
> Does this also apply to 2.4.22-rc2?
> 
> I must use noapic on my system and 2.4.22 does ignore it, while
> 2.4.21 doesn't.

Marcelo just pulled a bunch of ACPI fixes, so I would check the latest
BK, or wait for tonight's BK snapshot.

So, yes, it does apply to 2.4.22-rc2, but the Intel guys may have taken
care of it already.

	Jeff



