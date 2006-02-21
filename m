Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161448AbWBUJK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161448AbWBUJK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 04:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161450AbWBUJKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 04:10:25 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:19692 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161448AbWBUJKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 04:10:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Consolidated and improved smpnice patch
Date: Tue, 21 Feb 2006 20:09:46 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43F94D71.1040109@bigpond.net.au> <200602210941.23352.kernel@kolivas.org> <43FAB17B.8020608@bigpond.net.au>
In-Reply-To: <43FAB17B.8020608@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212009.47654.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 17:21, Peter Williams wrote:
> Con Kolivas wrote:
> > Would be just a matter of using task_timeslice(p) and making it
> > proportional to some baseline ensuring the baseline works at any HZ.
>
> How does the attached patch grab you?  It's independent of HZ.

Looks good thanks.

Cheers,
Con
