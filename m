Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUELMaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUELMaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUELMaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:30:25 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:11488 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S265036AbUELMaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:30:21 -0400
Date: Wed, 12 May 2004 08:30:21 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Long boot delay with 2.6 on Tyan S2464 Dual Athlon
Message-ID: <20040512123021.GA21957@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040511143514.GB27033@ti64.telemetry-investments.com> <20040511170238.36f9e5f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511170238.36f9e5f3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:02:38PM -0700, Andrew Morton wrote:
> > I've tried numerous option combinations in both the BIOS and the
> > kernel: MPS 1.1/1.4, (no-)SMP, acpi=off, pci=noacpi, noapic, nolapic,
> > nousb, etc.
> 
> Can you try adding earlyprintk=vga?  That might help identify where it got
> stuck.
 
My original mail included the boot log of 2.6.6-mm1 with earlyprintk=vga.

Just to clarify: GRUB prints its message indicating the kernel and initrd
load addresses, and then I don't see the kernel banner,

Linux version 2.6.6-mm1 (rugolsky@thor) (gcc version 3.3.2 20031107 (Red Hat Linux 3.3.2-2)) #1 SMP Tue May 11 08:57:29 EDT 2004

for two minutes (exactly, or very close).  I was hoping that someone could
point me in the direction of some timer that might be popping after two minutes.
Perhaps the two minute wait is just a red herring.

In any case, that machine had to be pressed into service.  I'll try to reproduce
on another Tyan mobo, and step it in the kernel debugger.  And perhaps I'll give
LinuxBIOS a try with 2.6, to see whether it is BIOS-specific.

	Bill Rugolsky
