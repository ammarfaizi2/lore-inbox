Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVIARXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVIARXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVIARXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:23:32 -0400
Received: from mail.joq.us ([67.65.12.105]:54190 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030253AbVIARXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:23:31 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Jackit-devel] Re: jack, PREEMPT_DESKTOP, delayed interrupts?
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
	<20050831073518.GA7582@elte.hu> <7q64tmnwbb.fsf@io.com>
	<20050831175036.5640e221@mango.fruits.de>
	<20050901073241.GA6641@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 01 Sep 2005 12:28:20 -0500
In-Reply-To: <20050901073241.GA6641@elte.hu> (Ingo Molnar's message of "Thu,
 1 Sep 2005 09:32:41 +0200")
Message-ID: <7q4q94lmtn.fsf@io.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> i suspect the confusion comes from the API hacks i'm using: user-space 
> tracing is started/stopped via:
>
> 	gettimeofday(0,1);
> 	gettimeofday(0,0);
>
> while 'jackd does not want to be scheduled' flag is switched on/off via:
>
> 	gettimeofday(1,1);
> 	gettimeofday(1,0);

D'oh!  No wonder I was confused.

Sorry to have mixed up the conversation with erroneous information,
but glad to have the gettimeofday() API clarified.
-- 
  joq
