Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbTBLSu7>; Wed, 12 Feb 2003 13:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbTBLSu7>; Wed, 12 Feb 2003 13:50:59 -0500
Received: from fmr01.intel.com ([192.55.52.18]:36589 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267394AbTBLSu5>;
	Wed, 12 Feb 2003 13:50:57 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A174@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: RE: was Re: [2.4.20][2.5.60] /proc/interrupts - Now: ACPI moving 
	of IRQs
Date: Wed, 12 Feb 2003 11:00:38 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Shawn Starr [mailto:spstarr@sh0n.net] 
> I see that you see APIC level
> 
>            CPU0
>   0:   12194031          XT-PIC  timer
>   1:         15          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   3:        149          XT-PIC  serial
>   5:          0          XT-PIC  soundblaster
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:         20          XT-PIC  aic7xxx
>  11:      49135          XT-PIC  uhci-hcd, eth0
>  12:         60          XT-PIC  i8042
>  14:       6082          XT-PIC  ide0
>  15:          9          XT-PIC  ide1
> NMI:          0
> LOC:   12193302
> ERR:          0
> MIS:          0
> 
> 
> Since this box has ACPI why didn't it move the PCI SCSI controller
> (aic7xxx) to a higher IRQ?
> 
> I thought this would happen with ACPI enabled?

This system appears to be in PIC mode, not IOAPIC mode, so irq 15 is as
high as it goes.

Regards -- Andy
