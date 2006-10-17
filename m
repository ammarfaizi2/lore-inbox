Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWJQTk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWJQTk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWJQTk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:40:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:51087 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751227AbWJQTk5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:40:57 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64: store Socket ID in phys_proc_id
Date: Tue, 17 Oct 2006 11:26:30 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6F9@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: store Socket ID in phys_proc_id
Thread-Index: AcbyGPiQWWrkqECQREeh6Mf9uLzwgQAAEdjg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 17 Oct 2006 18:26:31.0116 (UTC)
 FILETIME=[C47B58C0:01C6F219]
X-WSS-ID: 692BFFDD0C44737192-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen [mailto:ak@muc.de] 

>> So for the apic id lifted system, for example BSP with apicid 0x10,
the
>> phys_proc_id will be 8.

>How is that a problem? 

Socket ID is 0 for first Physical processor?

>> It also removed ht_nodeid calculating, because We already have
correct
>> socket id for sure.

>we've had cases where it wasn't identical, that is when i originally
>added that code.

OK, it must be system with Horus?

YH


