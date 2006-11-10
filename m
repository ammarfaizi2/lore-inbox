Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424406AbWKJUXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424406AbWKJUXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424404AbWKJUXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:23:43 -0500
Received: from outbound-red.frontbridge.com ([216.148.222.49]:48628 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1424402AbWKJUXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:23:41 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Fri, 10 Nov 2006 12:22:15 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071DE@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5 x86_64 irq 22: nobody cared
Thread-Index: AccFBKox12konx52R9OzrMPn6YpxZwAAIUDQ
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@suse.de>, "Olivier Nicolas" <olivn@trollprod.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 10 Nov 2006 20:22:16.0222 (UTC)
 FILETIME=[EA006BE0:01C70505]
X-WSS-ID: 694A00FD1X42334600-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 

>YH.  This is a completely different problem.  The irq is properly setup
>and received but none of the drivers wanted it.

The irq  with ioapic are shared with sata2 and audio, and later the
audio driver get the irq, and then try to get MSI.

The MAC first shared irq (ioapic) with SATA and it later transfer to use
MSI without problem.

YH


