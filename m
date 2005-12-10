Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbVLJT1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbVLJT1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 14:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbVLJT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 14:27:38 -0500
Received: from fmr18.intel.com ([134.134.136.17]:56736 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161030AbVLJT1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 14:27:37 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][PATCH] Kprobes - Increment kprobe missed count for multiprobes
Date: Sat, 10 Dec 2005 11:27:26 -0800
Message-ID: <44BDAFB888F59F408FAE3CC35AB47041028C99B7@orsmsx409>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][PATCH] Kprobes - Increment kprobe missed count for multiprobes
Thread-Index: AcX9YdhEoAcmGDJzRXe1iXVhFLd9BgAXWm2w
From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <ananth@in.ibm.com>, <prasanna@in.ibm.com>
X-OriginalArrivalTime: 10 Dec 2005 19:27:28.0024 (UTC) FILETIME=[C1B2F980:01C5FDBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good. I should have done a better job. Any way thanks Andrew.

-Anil Keshavamurthy

>-----Original Message-----
>From: Andrew Morton [mailto:akpm@osdl.org] 
>Sent: Saturday, December 10, 2005 12:15 AM
>To: Keshavamurthy, Anil S
>Cc: linux-kernel@vger.kernel.org; ananth@in.ibm.com; 
>prasanna@in.ibm.com
>Subject: Re: [BUG][PATCH] Kprobes - Increment kprobe missed 
>count for multiprobes
>
>Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>>
>>  +void __kprobes inc_nmissed_count(struct kprobe *p)
>
>That's not a good name for a global identifier.  I renamed it to
>kprobes_inc_nmissed_count().
>
