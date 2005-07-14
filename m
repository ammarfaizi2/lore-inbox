Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVGNRsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVGNRsC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVGNRsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:48:02 -0400
Received: from [212.76.87.160] ([212.76.87.160]:8964 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261639AbVGNRsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:48:00 -0400
Message-Id: <200507141742.UAA06527@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Vojtech Pavlik'" <vojtech@suse.cz>,
       "'Lee Revell'" <rlrevell@joe-job.com>,
       "'dean gaudet'" <dean-list-linux-kernel@arctic.org>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Brown, Len'" <len.brown@intel.com>, <dtor_core@ameritech.net>,
       <david.lang@digitalinsight.com>, <davidsen@tmr.com>,
       <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       <mbligh@mbligh.org>, <diegocg@gmail.com>, <azarah@nosferatu.za.org>,
       <christoph@lameter.com>
Subject: RE: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Thu, 14 Jul 2005 20:42:17 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1121360561.3967.55.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWIlxyHOEWTrWupRN6jc/yJPupHwwAA9dHQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 09:37 -0700, Linus Torvalds wrote:
>
> There's absolutely nothing wrong with "jiffies", and anybody who 
> thinks that
> 
> 	msleep(20);
> 
> is fundamentally better than
>
> 	timeout = jiffies + HZ/50;
>

What's wrong with structured programming?

