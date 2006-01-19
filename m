Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWASQUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWASQUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWASQUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:20:37 -0500
Received: from fmr17.intel.com ([134.134.136.16]:63949 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161179AbWASQUg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:20:36 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [2.6 patch] kernel/kprobes.c: fix a warning #ifndef ARCH_SUPPORTS_KRETPROBES
Date: Thu, 19 Jan 2006 08:18:15 -0800
Message-ID: <44BDAFB888F59F408FAE3CC35AB4704102CF809E@orsmsx409>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] kernel/kprobes.c: fix a warning #ifndef ARCH_SUPPORTS_KRETPROBES
Thread-Index: AcYcncmtryta9FRSR62Vv4SF5LkN/QAdchNA
From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <prasanna@in.ibm.com>, <ananth@in.ibm.com>, <davem@davemloft.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jan 2006 16:18:17.0047 (UTC) FILETIME=[F4835670:01C61D13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	This patch looks good to me and Acking this patch, please apply.

-Anil Keshavamurthy

>From: Adrian Bunk [mailto:bunk@stusta.de] 
>Sent: Wednesday, January 18, 2006 6:12 PM
>To: Andrew Morton
>Cc: prasanna@in.ibm.com; ananth@in.ibm.com; Keshavamurthy, 
>Anil S; davem@davemloft.net; linux-kernel@vger.kernel.org
>Subject: [2.6 patch] kernel/kprobes.c: fix a warning #ifndef 
>ARCH_SUPPORTS_KRETPROBES
>
>This patch fixes the following warning #ifndef 
>ARCH_SUPPORTS_KRETPROBES:
>
><--  snip  -->
>
>...
>  CC      kernel/kprobes.o
>kernel/kprobes.c:353: warning: 'pre_handler_kretprobe' defined 
>but not used
>...
>
><--  snip  -->
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

>
>---
>
>This patch was already sent on:
>- 14 Jan 2006

