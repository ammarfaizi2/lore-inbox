Return-Path: <linux-kernel-owner+w=401wt.eu-S932200AbXADAAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbXADAAT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbXADAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:00:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:30172 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200AbXADAAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:00:18 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="181195868:sNHT80969840"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Date: Wed, 3 Jan 2007 15:59:28 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C01A4FB27@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <20070103074124.GA25594@gnuppy.monkey.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Thread-Index: AccvCppHvAMyz9vrQKqJeaMpwiIGswAheiAg
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Bill Huey \(hui\)" <billh@gnuppy.monkey.org>,
       "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 03 Jan 2007 23:59:32.0586 (UTC) FILETIME=[369634A0:01C72F93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> 
> Patch here:
> 
>
http://mmlinux.sourceforge.net/public/patch-2.6.20-rc2-rt2.2.lock_stat.p
atch
> 
> bill

This version is much better and ran stablely.  

If I'm reading the output correctly, the locks are listed by 
their initialization point (function, file and line # that a lock is
initialized).  
That's good information to identify the lock.  

However, it will be more useful if there is information about where the
locking
was initiated from and who was trying to obtain the lock.

Tim
