Return-Path: <linux-kernel-owner+w=401wt.eu-S932229AbXADBLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbXADBLN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 20:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXADBLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 20:11:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:13093 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932229AbXADBLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 20:11:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="32722967:sNHT22704210"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Date: Wed, 3 Jan 2007 17:11:04 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C01A4FBE5@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <20070104010049.GA31943@gnuppy.monkey.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Thread-Index: Accvm9BFtBP1R1q0Tk2V5qgrXcdf3AAADizg
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Bill Huey \(hui\)" <billh@gnuppy.monkey.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 04 Jan 2007 01:11:04.0903 (UTC) FILETIME=[3501CD70:01C72F9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> 
> Thanks, the numbers look a bit weird in that the first column should
> have a bigger number of events than that second column since it is a
> special case subset. Looking at the lock_stat_note() code should show
> that to be the case. Did you make a change to the output ?

No, I did not change the output.  I did reset to the contention content

by doing echo "0" > /proc/lock_stat/contention.

I noticed that the first column get reset but not the second column. So
the reset code probably need to be checked.

Tim
