Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLPCNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLPCNI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVLPCNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:13:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:15325 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932076AbVLPCNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:13:06 -0500
Message-ID: <00b201c601e6$30c87ff0$d6069aa3@johnhaonw7lw1r>
From: "John Hawkes" <hawkes@sgi.com>
To: "Lee Revell" <rlrevell@joe-job.com>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Jack Steiner" <steiner@sgi.com>,
       "Keith Owens" <kaos@sgi.com>, "Dimitri Sivanich" <sivanich@sgi.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com> <20051215225040.GA9086@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com> <1134698636.12086.222.camel@mindpipe>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Date: Thu, 15 Dec 2005 18:12:39 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lee Revell" <rlrevell@joe-job.com>
> There are 10 drivers that udelay(10000) or more and a TON that
> udelay(1000).  Turning those all into 1ms+ non preemptible sections will
> be very bad.

What about 100usec non-preemptible sections?
John Hawkes
