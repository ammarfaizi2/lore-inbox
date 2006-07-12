Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWGLQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWGLQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWGLQL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:11:59 -0400
Received: from outbound-haw.frontbridge.com ([12.129.219.97]:65424 "EHLO
	outbound2-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751449AbWGLQL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:11:58 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Wed, 12 Jul 2006 11:11:38 -0500
Message-ID: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: AcalvIl3WTDtGRvXQ8WZBSrvZbm9OwAD7mPQ
From: "shin, jacob" <jacob.shin@amd.com>
To: "Deguara, Joachim" <joachim.deguara@amd.com>, "Andi Kleen" <ak@suse.de>
cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 12 Jul 2006 16:11:39.0134 (UTC)
 FILETIME=[DB3721E0:01C6A5CD]
X-WSS-ID: 68ABC0B127K16479553-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 12, 2006 9:06 AM Joachim Deguara wrote:

> Here are the further findings after letting the machine toggle between
> 1GHz and 2.2Ghz every two seconds for roughly 24 hours.  Unfortunately
> there is an oops after bringing CPU2 online and CPU3 will not come
> online.  Still the differences in TSC are not bad:

Can I get more information on how to reproduce the Oops? Kernel version?
.config? your hardware?

I have run basic set of CPU Hotplug on/offline tests, and I could not
reproduce it..

-Jacob Shin
AMD, Inc.


