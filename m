Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130985AbRBVViy>; Thu, 22 Feb 2001 16:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbRBVVio>; Thu, 22 Feb 2001 16:38:44 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:65254 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130985AbRBVVid>; Thu, 22 Feb 2001 16:38:33 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE6C5@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Petr Vandrovec'" <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: RE: Using ACPI to get PCI routing info?
Date: Thu, 22 Feb 2001 13:38:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are definitely plans to do this, and in fact on IA64 ACPI is already
used to obtain PCI routing. However, IA32 ACPI efforts have been focused on
other things, since we assumed MPS tables would be around for a while
longer. I guess that is no longer a correct assumption.

So yes, there are plans. ;-)

Regards -- Andy

> Hi,
>   Gigabyte (and/or AMI and/or VIA) decided that it is not worth 
> of effort to create full mptable and since version F5a for 6VXD7 
> they do not report PCI interrupts as 16-19, but only as traditional 
> 0-15 (and they do not report them as conforms/conforms, but as 
> active-lo/level).
> 
>   For now I hardwired correct routing table into my kernel, as
> I have other uses for IRQ < 16, but after some investigation I 
> found that ACPI _SB_.PCI0._PRT element returns correct routing 
> table (using IRQ 16-19). So my question is, are there any plans 
> to use ACPI tables to get IRQ routing tables, or should I complain 
> to Gigabyte that I'm not satisfied (I'll complain anyway, but...)?
> 
> 					Thanks,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
> 
> P.S.: No, there is no MPS1.1/MPS1.4 switch in BIOS (anymore) :-(
> And no, there is no way to disable ACPI in that BIOS :-((

