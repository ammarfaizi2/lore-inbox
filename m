Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWJQSFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWJQSFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWJQSFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:05:41 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:16614 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751407AbWJQSFk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:05:40 -0400
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Date: Tue, 17 Oct 2006 11:05:31 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6F7@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Thread-Index: AcbyFf1cHBufMDcSTeWa1j358q9k2wAADHQg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 17 Oct 2006 18:05:32.0072 (UTC)
 FILETIME=[D6087A80:01C6F216]
X-WSS-ID: 692BC4E60CK4517784-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
>I just looked and tested and we are fine.

Yes. my test is ok, We can change cpumask_of_cpu(0) in
physflat_target_cpus to cpu_online_map. Or just use flat_target_cpus
instead of physflat_target_cpus.

YH


