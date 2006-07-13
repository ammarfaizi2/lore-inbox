Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWGMOlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWGMOlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWGMOlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:41:07 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:33781 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751553AbWGMOlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:41:05 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 changepstate at same time
Date: Thu, 13 Jul 2006 09:40:46 -0500
Message-ID: <B3870AD84389624BAF87A3C7B831499302935A88@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 changepstate at same time
Thread-Index: AcamiTYFZQazN9skSMOUgLG8PqAs5AAAEelA
From: "shin, jacob" <jacob.shin@amd.com>
To: "Deguara, Joachim" <joachim.deguara@amd.com>,
       "Pavel Machek" <pavel@suse.cz>
cc: "Andi Kleen" <ak@suse.de>, "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk, "Bhavana Nagendra" <bnagendr@redhat.com>
X-OriginalArrivalTime: 13 Jul 2006 14:40:46.0755 (UTC)
 FILETIME=[53C1DF30:01C6A68A]
X-WSS-ID: 68A884E427K16555919-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 13, 2006 9:32 AM Deguara, Joachim wrote:

> parallel sounds fun, but I don't get it.  Two machine or trying to go
> online and offline at the same time?  Firestorming two busy parallel
> while loops, one turning the core offline and the other online, did
> not bring an oops so I guess this kernel is in the clear in that
> regard. 
>
> I can't get it to crash again and I am afraid that it crashed under an
> old devel kernel.  After another ~20 hour test with heavy freq changes
> with the tscsync patch

There were several different issues w/ powernow + cpu hotplug in the
past.  Good to hear that the latest kernel doesn't oops.. I believe 
cpu hotplug is needed for suspend to work..


