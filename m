Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWJ3Rd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWJ3Rd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbWJ3Rd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:33:59 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:19129 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030564AbWJ3Rd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:33:57 -0500
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: AMD X2 unsynced TSC fix?
Date: Mon, 30 Oct 2006 11:22:45 -0600
Message-ID: <1449F58C868D8D4E9C72945771150BDF153775@SAUSEXMB1.amd.com>
In-Reply-To: <1162058915.14733.2.camel@mindpipe>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AMD X2 unsynced TSC fix?
Thread-Index: Acb6vCNI2iQIilqMRjmEnvBD8ZrqYwBi3aiQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Lee Revell" <rlrevell@joe-job.com>
cc: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 30 Oct 2006 17:22:45.0765 (UTC)
 FILETIME=[03C3DB50:01C6FC48]
X-WSS-ID: 6958EB6C280967181-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Agreed, I had to turn about 20 dual-core servers to single 
> > core because the only way to get a monotonic gtod made it
> > so slow that it was not worth using a dual-core. I initially
> > considered buying one dual-core AMD for my own use, but after
> > seeing this, I'm definitely sure I won't ever buy one as
> > long as this problem is not fixed, as it causes too
> > many problems.
> 
> Does anyone know if the problem will really be fixed in new 
> CPUs, as AMD promised a year or so ago?
> 
> http://lkml.org/lkml/2005/11/4/173
> 
> Since that post, there has been Socket F and AM2 which apparently have
> the same issue. 
> Were the AMD guys just blowing smoke?

AMD was not blowing smoke.  Future AMD processors will have 
pstate/cstate invariant TSCs detectable by a CPUID bit.

Unfortunately, those processors have not be released yet, and
I can't comment on their release timeframe, other than to say
they are on our roadmap.

-Mark Langsdorf
AMD, Inc.


