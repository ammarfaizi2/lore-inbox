Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937618AbWLFUth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937618AbWLFUth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937629AbWLFUth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:49:37 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:47674 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937618AbWLFUtg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:49:36 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug
 port support.
Date: Wed, 6 Dec 2006 12:43:08 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug
 port support.
Thread-Index: AccZXktBtyNR4ocFQoC6aKn0Q0K7SgAF6Wgw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>
cc: "David Brownell" <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       "Stefan Reinauer" <stepan@coresystems.de>, "Greg KH" <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org
X-OriginalArrivalTime: 06 Dec 2006 20:43:09.0679 (UTC)
 FILETIME=[23DC47F0:01C71977]
X-WSS-ID: 6969F4D71WC2258864-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de] 
Sent: Wednesday, December 06, 2006 9:31 AM

>Also for usb console keep should be made default because the output
won't
>be duplicated.

Still need to tx_read to make console can take command?

Or transfer to generic usb_serial or usb_debug that Greg just added with
console=ttyUSB0 to get tty? Then you still need to disable that
early_console sometime later.

YH


