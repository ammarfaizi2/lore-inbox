Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWFHIkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWFHIkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFHIkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:40:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2245 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932565AbWFHIkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:40:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=HTFpZqCehP4BMIB+x+/bCgEStSwSXCHeIJ4lR/sSWVHl6PrxSsPZydg3yfnLDJXBWxvyY9vX8CZsMX3JnI167pXafgS7lWz5Foa3j7+lDA61vycDhrFB+J2AhjmKFb/BzIuhgZwOoiYsJMtWacTbgVruCxa2/rx/5N1+cFW/LZg=
Date: Thu, 8 Jun 2006 10:40:27 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, mchan@broadcom.com
Subject: Re: tg3 broken on 2.6.17-rc5-mm3
Message-ID: <20060608084027.GA952@slug>
References: <200606071711.06774.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606071711.06774.bjorn.helgaas@hp.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 05:11:06PM -0600, Bjorn Helgaas wrote:
> I'll try to narrow down the problem tomorrow, but I'll post this in
> case it's obvious to somebody.
> 
FYI, it was OK for me on x86 with both rc5-mm2 and rc5-mm3 (dmesg from mm3)
[   20.749964] tg3.c:v3.59 (May 26, 2006)
[   20.749993] ACPI (acpi_bus-0192): Device `NIC]is not power manageable [20060310]
[   20.750008] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   20.750023] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   20.788136] eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:14:22:c6:f6:a0

Regards,
Frederik
