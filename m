Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbTHYSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbTHYSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:21:58 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:5036 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S262147AbTHYSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:21:56 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: 2.6.0test4 ACPI with nForce2 success
Date: Mon, 25 Aug 2003 19:21:51 +0100
User-Agent: KMail/1.5.9
References: <1061834424.2599.2.camel@aurora.localdomain>
In-Reply-To: <1061834424.2599.2.camel@aurora.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308251921.51305.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 August 2003 19:00, Trever L. Adams wrote:
> I have been one of these people who have been having to boot with
> pci=noacpi to get up with much of my hardware initialized.  My system is
> now working without it.  It isn't getting shutoff on irq storms or
> anything.

Likewise, my EPoX 8RDA+ board is working 100% perfectly since the nforce2-apic 
fixes were merged in -mm. No spurious interrupts, no weird ACPI glitches, 
everything from power management to PCI IRQ routing is just fine.

I'm still not sure I understand the local apic lockups experienced by others, 
but anybody considering the purchase of an nForce 2 board can probably put 
their mind to rest.

>
> My only possible problem is this:
>
>  13:59:40  up 8 min,  3 users,  load average: 0.86, 0.81, 0.36
>            CPU0
>   0:     516847          XT-PIC  timer

With the 1000Hz timer in linux 2.6, I'd guess your PC had been up for 
516847/1000/60 = 8.61 minutes.. Oh, look!

>
> I am not sure how fast the irq's for the timer should be going up.  So,
> that may be an issue.
>

Evidently not.

Cheers,
Alistair.
