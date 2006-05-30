Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWE3SrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWE3SrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWE3SrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:47:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:12429 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932381AbWE3SrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:47:11 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="43364951:sNHT41008688"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] hrtimer: export symbols
Date: Tue, 30 May 2006 11:47:09 -0700
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC07518A4B@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] hrtimer: export symbols
thread-index: AcaC442/hv7xieY/SGiTQwy83pv+SgBMvSPw
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: "Stephen Hemminger" <shemminger@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <ananth@in.ibm.com>
X-OriginalArrivalTime: 30 May 2006 18:47:09.0910 (UTC) FILETIME=[75074F60:01C68419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 14:26:31 -0700, Stephen Hemminger wrote:
> I want to use the hrtimer's in the netem (Network Emulator) qdisc.
> But the necessary symbols aren't exported for module use.

I second this request -- we would like to use hrtimers in SystemTap
modules.  The patch that Stephen provided would be sufficient for our
use as well.

I requested this a few months ago, and it was rejected on grounds that
the API was not yet stable enough for export.  I hope that now it has
had time to settle so that modules may use the new API.

Thanks,

Josh Stone
