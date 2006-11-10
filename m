Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161942AbWKJSZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161942AbWKJSZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161944AbWKJSZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:25:07 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:60009 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161942AbWKJSZE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:25:04 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Fri, 10 Nov 2006 10:20:58 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071D9@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5 x86_64 irq 22: nobody cared
Thread-Index: AccEroVUW44BdLukSuSTWnsxTIAIOgARK99w
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@suse.de>, "Olivier Nicolas" <olivn@trollprod.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>
cc: "Adrian Bunk" <bunk@stusta.de>, "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 10 Nov 2006 18:21:00.0329 (UTC)
 FILETIME=[F93B4190:01C704F4]
X-WSS-ID: 694A1C861X42312299-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

The two patches solve the problems that irq nobody care.

They are already in your tree. But first one I wonder if you put correct
one in your tree.


YH

[PATCH] x86_64 irq: reuse vector for __assign_irq_vector 
http://lkml.org/lkml/2006/10/26/38
[PATCH] x86_64 irq: reset more to default when clear irq_vector for
destroy_irq
http://lkml.org/lkml/2006/10/28/16



