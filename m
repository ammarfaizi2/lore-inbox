Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752048AbWJWW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWJWW6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWJWW6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:58:36 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:16710 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752048AbWJWW6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:58:35 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity
 in phys flat mode
Date: Mon, 23 Oct 2006 15:57:44 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D753@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity
 in phys flat mode
Thread-Index: Acb29PZqiQrjMhYqRXOk2C3vtxTWVwAAVdow
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Adrian Bunk" <bunk@stusta.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Andi Kleen" <ak@muc.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 23 Oct 2006 22:57:45.0630 (UTC)
 FILETIME=[A7539BE0:01C6F6F6]
X-WSS-ID: 692397631X4141056-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Adrian Bunk [mailto:bunk@stusta.de] 
>Sent: Monday, October 23, 2006 1:45 PM

>Is this patch intended as fix for the 2.6.19-rc regression described 
>in [1]?


>[1] http://lkml.org/lkml/2006/10/21/227

This patch is intended to reuse vector between cpus in phys_flat when
using irq balance to different cpus.

YH


