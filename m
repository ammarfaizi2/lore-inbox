Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVIDQTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVIDQTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 12:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIDQTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 12:19:39 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:7133 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750778AbVIDQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 12:19:39 -0400
Date: Sun, 4 Sep 2005 12:18:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Brand-new notebook useless with Linux...
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>
Message-ID: <200509041219_MC3-1-A924-5ED7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <E1EBje3-0002GW-00@chiark.greenend.org.uk>

On Sun, 4 Sep 2005 at 02:50:07 +0100, Matthew Garrett wrote:

> > Additionally, the system clock runs at 2x normal speed with PowerNow enabled.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=3927

 Well that's the most bizarre tale of timer interrupt routing I've seen
to date.  Has Maciej seen this? (cc'd)


I have these messages:

ACPI: PM-Timer IO Port: 0x8008
Using pmtmr for high-res timesource
Calibrating delay using timer specific routine.. 3205.65 BogoMIPS (lpj=6411312)
.TIMER: vector=0x31 pin1=2 pin2=-1


and:

ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)

__
Chuck
