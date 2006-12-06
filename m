Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937644AbWLFVL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937644AbWLFVL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937645AbWLFVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:11:29 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:15439 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937644AbWLFVL2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:11:28 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug
 port support.
Date: Wed, 6 Dec 2006 13:08:14 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907291@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug
 port support.
Thread-Index: AccZeXwnv0g3EBFvRlmY7WTW4oapxwAAMpHA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@suse.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "David Brownell" <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       "Stefan Reinauer" <stepan@coresystems.de>, "Greg KH" <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org
X-OriginalArrivalTime: 06 Dec 2006 21:08:15.0567 (UTC)
 FILETIME=[A5708DF0:01C7197A]
X-WSS-ID: 6969EEB51WC2260792-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de] 
Sent: Wednesday, December 06, 2006 12:59 PM

>I haven't looked how the other usb_debug works -- if it's polled
>too then it wouldn't have much advantage.

Need to verify if the two sides of debug cable are identical. 

>And it would be good if the late usb_debug still wouldn't rely
>on interrupts.

Yes, esp. when usb can not get irq assigned correctly.

YH


