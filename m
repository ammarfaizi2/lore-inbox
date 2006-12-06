Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758343AbWLFADn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343AbWLFADn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757769AbWLFADn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:03:43 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:51382 "EHLO
	outbound1-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757385AbWLFADl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:03:41 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early
 usb debug port support.
Date: Tue, 5 Dec 2006 16:00:22 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490728B@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64
 Early usb debug port support.
Thread-Index: AccYyCSUIlNgZxZJQu2vQEhuCElgSQAATcug
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "David Brownell" <david-b@pacbell.net>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, "Greg KH" <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 06 Dec 2006 00:00:24.0410 (UTC)
 FILETIME=[877F2BA0:01C718C9]
X-WSS-ID: 6968D79D1WC2185414-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Tuesday, December 05, 2006 3:50 PM


>If you will not reps is negative.  Roughly it is a loop
>that will timeout eventually if a usb debug cable is not present.
>Putting some deliberate delays in there so I could be certain
>of timing out after a second or two would probably be better, but
>I don't have anything that resembles a good timer at that point.

You have dbgp_mdelay in your code.

YH


