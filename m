Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937365AbWLDUWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937365AbWLDUWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937367AbWLDUWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:22:04 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:5557 "EHLO
	outbound1-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937365AbWLDUWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:22:00 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device
 support.
Date: Mon, 4 Dec 2006 12:18:30 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907280@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device
 support.
Thread-Index: AccXY6GBfE/1dv4LRw+DIFj6KnGcLQAfMJxA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com,
       "USB development list" <linux-usb-devel@lists.sourceforge.net>
cc: "Greg KH" <gregkh@suse.de>, "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 04 Dec 2006 20:18:32.0143 (UTC)
 FILETIME=[5E5AADF0:01C717E1]
X-WSS-ID: 696A5D1D0T02050223-05-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 

>arch/x86_64/kernel/early_printk.c |  574
+++++++++++++++++++++++++++++++++++++
> drivers/usb/host/ehci.h           |    8 +
> include/asm-x86_64/fixmap.h       |    1 

Can you separate usbdebug handle out from early_printk? 
So We can share the code in LinuxBIOS easier. I like the version like
usbdebug_direct.c.
Also separate related USB debug port defines in one separate header file
too.

YH



