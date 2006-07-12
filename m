Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWGLQSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWGLQSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWGLQSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:18:32 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:945 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751453AbWGLQSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:18:31 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Wed, 12 Jul 2006 11:14:27 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218EB7@SAUSEXMB1.amd.com>
In-Reply-To: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: AcalvIl3WTDtGRvXQ8WZBSrvZbm9OwAD7mPQAABofiA=
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "shin, jacob" <jacob.shin@amd.com>,
       "Deguara, Joachim" <joachim.deguara@amd.com>, "Andi Kleen" <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 12 Jul 2006 16:14:28.0877 (UTC)
 FILETIME=[4063DBD0:01C6A5CE]
X-WSS-ID: 68ABC06E27K16479796-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here are the further findings after letting the machine 
> toggle between
> > 1GHz and 2.2Ghz every two seconds for roughly 24 hours.  
> Unfortunately
> > there is an oops after bringing CPU2 online and CPU3 will not come
> > online.  Still the differences in TSC are not bad:
> 
> Can I get more information on how to reproduce the Oops? 
> Kernel version?
> .config? your hardware?
> 
> I have run basic set of CPU Hotplug on/offline tests, and I could not
> reproduce it..

There's probably something in my patch that is causing it.
Are you testing with that?

Joachim -

Have you had a chance to measure TSC drift without 
PN?  I'd like to know if the patch is making the problem
worse or not.

-Mark Langsdorf
AMD, Inc.


