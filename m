Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVKLV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVKLV5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVKLV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:57:45 -0500
Received: from fmr20.intel.com ([134.134.136.19]:9943 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964800AbVKLV5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:57:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Documentation for CPU hotplug support
Date: Sat, 12 Nov 2005 13:56:43 -0800
Message-ID: <A28EFEDC5416054BA1026D892753E9AF0BBDD08C@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Documentation for CPU hotplug support
thread-index: AcXnyo2jLP5So1V6Rh2TC3Qo3NaLYwACNVuQ
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Nathan Lynch" <nathanl@austin.ibm.com>, <linux-kernel@vger.kernel.org>,
       <ak@muc.de>, <rusty@rustycorp.com.au>, <vatsa@in.ibm.com>,
       <jschopp@austin.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
X-OriginalArrivalTime: 12 Nov 2005 21:56:44.0427 (UTC) FILETIME=[F8909DB0:01C5E7D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Ashok was my patch for the cpufreq driver *that* horrible? Or perhaps
we
>just need to move things like the set_cpus_allowed further up in the
calls
>and handle everything in one location. Interested?
>

I have been on to multiple things recently, I think I saw your post, but
didn't look at it closer.

Yes, moving things higher up would definitely help, especially the
set_cpus_allowed(). 

We should also do the same for the case where we have the list of
dependent cpus in the mask before calling the lower level functions. 

Zwane, if you want to take a shot at it, that would be awesome.. I might
not be able to get to this immediately.

