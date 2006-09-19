Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWISHqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWISHqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 03:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWISHqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 03:46:42 -0400
Received: from mgw-ext11.nokia.com ([131.228.20.170]:56131 "EHLO
	mgw-ext11.nokia.com") by vger.kernel.org with ESMTP
	id S1751246AbWISHql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 03:46:41 -0400
Subject: Re: [linux-pm] PowerOP vs OPpoint
From: Amit Kucheria <amit.kucheria@nokia.com>
To: ext Jon Loeliger <jdl@freescale.com>
Cc: Matthew Locke <matthew.a.locke@comcast.net>,
       pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1158610046.6962.186.camel@cashmere.sps.mot.com>
References: <ff355e0e9a7ba8350241ffe483c664ab@comcast.net>
	 <1158610046.6962.186.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Nokia
Date: Tue, 19 Sep 2006 10:44:05 +0300
Message-Id: <1158651846.14353.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 19 Sep 2006 07:46:31.0687 (UTC) FILETIME=[B9127970:01C6DBBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 15:07 -0500, ext Jon Loeliger wrote:
> On Thu, 2006-09-14 at 04:22, Matthew Locke wrote:
> > Unfortunately, there are two efforts underway that makes this confusing 
> > and I think require a bit more than the short summary requested.  A one 
> > paragraph summary can't address the why and how.  This email briefly 
> > describes the why and the differences.
> > 
> > There are two main reasons for both these efforts:
> > - existing power management interfaces do not enable the power 
> > management features on the latest SOC's used in embedded mobile  
> > devices
> > - existing power management interfaces do not provide the API necessary 
> > to build power managers (userspace and/or kernel space) that optimize 
> > power consumption to level required by embedded mobile devices
> 
> So does it make sense to re-unify these two patch-sets
> into one common, more general patch-set first?  Might
> it make sense to do so in small, incremental steps that
> everyone can agree on as we go along?

That has been the idea. Maybe if you have better way to 'communicate'
with David Singleton (oppoint) since he refuses to be drawn into the
merge discussions.

> For example, maybe the very first thing to do is define
> some notion of general "operating point" that is a super-set
> of the cpufreq definition.   If we can define that structure
> maybe we can progress towards introducing and using it.

Yes, it is a good first step. Please comment on the PowerOP patches to
see if there is something in the OP notion that is missing in your
opinion.

> Totally side-step the kernel-user level stuff for a bit...
> Totally side-step the suspend/resume issues for a bit...

I believe the PowerOP patches from Eugeny and Matt do not touch
suspend-resume issues and make the kernel-userspace interface to define
OP as an optional patch.

Oppoing patches on the other hand touch those issues.

Regards,
Amit

-- 
Amit Kucheria <amit.kucheria@nokia.com>
Nokia
