Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTFXNCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFXNCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 09:02:18 -0400
Received: from [194.38.131.35] ([194.38.131.35]:42948 "HELO
	www1.onevision-design.com") by vger.kernel.org with SMTP
	id S262018AbTFXNCR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 09:02:17 -0400
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto 
	<sbasto@onevision-design.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: linux-kernel@vger.kernel.org,
       acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20030624063612.GB20235@alf.amelek.gda.pl>
References: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
	 <20030624063612.GB20235@alf.amelek.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 24 Jun 2003 14:16:04 +0100
Message-Id: <1056460565.1430.15.camel@darkstar.portugal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 07:36, Marek Michalkiewicz wrote:
> On Mon, Jun 23, 2003 at 03:23:48PM -0700, Grover, Andrew wrote:
> > Is this an SMP machine?
> 
> No, it's a low cost Socket-370 Micro-ATX board with built-in VGA and
> RTL8139 LAN, VT8601/VT82C686A chipset, Celeron 1200A processor.

I have a laptop presario 7xx that have one VIA mother board 
with built-in VGA and RTL8139 LAN.

BTW: I have to disable APIC since the begging, because APIC enable,
without acpi cause oops, and with acpi doesn't boot.
my acpi works alone on irq 10 happily.
 
> 
> Some of the kernel build options:
> 
> CONFIG_MPENTIUMIII=y
> CONFIG_SMP=n
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> 
> But, there are some SMP-related boot messages:
> 
> found SMP MP-table at 000f6430
> 
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.

So maybe you should compile with smp support ,

> 
> I can provide the complete boot messages if necessary.
> 
of course we want see the complete dmesg 


-- 
Sérgio Basto


