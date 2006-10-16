Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWJPUGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWJPUGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWJPUGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:06:25 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:33351 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750802AbWJPUGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:06:23 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Date: Mon, 16 Oct 2006 12:52:06 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6E7@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Thread-Index: AcbxW4Z8fHFBx7NIT4Oq9CwtrR+eYwAADPqA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 16 Oct 2006 19:52:06.0961 (UTC)
 FILETIME=[8F455A10:01C6F15C]
X-WSS-ID: 692D39910C44653950-07-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So to get things going making TARGET_CPUS cpu_online_map looks like
>the right thing to do.

Yes. but need to other reference to TARGET_CPUS to verify...it doesn't
break sth.

>My question is are your io_apics pci devices?  Not does the kernel
>have them.

Yes, I'm testing with 32 amd8132 in the simulator. Or forget about about
ioapic, and use MSI, and HT-irq directly...?

>There are a lot of ways we can approach assigning irqs to cpus and
there
>is a lot of work there.  I think Adrian Bunk has been doing some work
>with the user space irq balancer, and should probably be involved.

Right. We need only do needed in kernel space, and leave most to irq
balancer.

YH





