Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422788AbWJPS2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWJPS2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbWJPS2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:28:00 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:7127 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1422788AbWJPS17 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:27:59 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Date: Mon, 16 Oct 2006 11:27:08 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6E2@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Thread-Index: AcbxTgtywUOf0kGrTLaE4r3PFgepVgAAd2ng
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 16 Oct 2006 18:27:09.0913 (UTC)
 FILETIME=[B1318C90:01C6F150]
X-WSS-ID: 692D11770C44649962-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With phys_flat mode, the apic will be delivered in phys mode, we only
can use cpu real apic id as target instead of apicid mask. Because that
only has 8 bits. 

For io apic controllers, it seems the kernel didn't have pci_dev
corresponding, and we can use address stored in mpc_config.

YH


