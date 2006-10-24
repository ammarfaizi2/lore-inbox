Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWJXSpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWJXSpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWJXSpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:45:22 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:37687 "EHLO
	outbound3-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161176AbWJXSpV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:45:21 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Date: Tue, 24 Oct 2006 11:45:10 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D75A@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Thread-Index: Acb29PZqiQrjMhYqRXOk2C3vtxTWVwApoRYQ
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
X-OriginalArrivalTime: 24 Oct 2006 18:45:11.0556 (UTC)
 FILETIME=[89352C40:01C6F79C]
X-WSS-ID: 692080BD1X4227778-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Andi Kleen [mailto:ak@suse.de]
>Is that still needed with Eric's latest patches? I suppose not?

It needs Eric's

x86_64-irq-simplify-the-vector-allocator.patch
x86_64-irq-only-look-at-per_cpu-data-for-online-cpus.patch

Those two are in -mm tree now.

Otherwise it can not be applied without FAIL.

YH



