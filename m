Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVKKGSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVKKGSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 01:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVKKGSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 01:18:47 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:57400 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S932348AbVKKGSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 01:18:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Reading BIOS information from a kernel driver
Date: Thu, 10 Nov 2005 22:14:16 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C328D459@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reading BIOS information from a kernel driver
Thread-Index: AcXmgREK/pr6DzrITrC9+BvCtedYewABhQ00
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Steven Schveighoffer" <StevenS@NetworkEngines.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Nov 2005 06:18:46.0262 (UTC) FILETIME=[C5C06160:01C5E687]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org]
Sent: Thu 11/10/2005 9:30 PM
To: Aleksey Gorelov
Cc: Steven Schveighoffer; linux-kernel@vger.kernel.org
Subject: RE: Reading BIOS information from a kernel driver
 

>> 
>> I think you are looking for phys_to_virt(0xffa00)

>and ioremap

Well, area in question is always mapped... So, phys_to_virt OR ioremap 
will do the right thing - in fact, ioremap implementation 
actually does phys_to_virt for 0xa0000 - 0x100000





