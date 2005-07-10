Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVGJSuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVGJSuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGJSuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:50:55 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:34065 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S261153AbVGJSuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:50:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Sun, 10 Jul 2005 13:50:50 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C45@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Thread-Index: AcWFJ1Of0LtOS6rmSfKB9BhUy29kigAWMM5w
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Michel Bouissou" <michel@bouissou.net>, <linux-kernel@vger.kernel.org>
Cc: <stern@rowland.harvard.edu>, <mingo@redhat.com>
X-OriginalArrivalTime: 10 Jul 2005 18:50:50.0529 (UTC) FILETIME=[4AB01910:01C58580]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Michel Bouissou
> Sent: Sunday, July 10, 2005 2:11 AM
> To: linux-kernel@vger.kernel.org
> Cc: stern@rowland.harvard.edu; mingo@redhat.com
> Subject: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
> 
> Hi there,
> 
> I use a Gigabyte GA7-VAXP motherboard that has been fine for 
> more than 2 years with 2.4 series kernels, and that gives 
> trouble with 2.6.12 (and previous) kernels.
> 
> The problem seems to sit between the UP IO-APIC and USB 
> uhci_hcd driver.
> 
> The GA7-VAXP MB is equipped with an Athlon 2000+ XP and a VIA 
> KT400 chipset.
> 
> Using 2.4 series kernel the IO-APIC is used just fine.  Was 
> never source of any kind of problem.
> 
> Using 2.6.12 kernel, if the IO-APIC is enabled in the kernel 
> configuration, then the interrupt controlling the uhci_hcd 
> USB controller gets disabled as soon as uhci_hcd is initialized.

Michel,
Symptoms that you describe resemble several IRQ problems with VIA
chipset reported by others (but not quite...) Could you check on
bugzilla #4843 please
http://bugzilla.kernel.org/show_bug.cgi?id=4843 and see if the patch
fixes your problem.
Thanks,
--Natalie
 
 
