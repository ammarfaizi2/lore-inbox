Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWCWAbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWCWAbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWCWAbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:31:47 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:52910 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964909AbWCWAbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:31:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MssXrtp74o+jxDLbBE0Yx9S0lq0GMNfXwm8RLTiO58EYSptkxt/j6937sRoXVbZo7VAACe+fpafD2JafZzUYR4/ctBgv5PIe+DSV2a/Law45eAxJaD6DdeatvFVJ8FMCaE2dcnIxPo4H1b2LyC7yVLTMflJpY2kw7Q1X2anVle0=  ;
Message-ID: <4421EC6B.5070603@yahoo.com.au>
Date: Thu, 23 Mar 2006 11:31:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: cpu scheduler merge plans
References: <20060322155122.2745649f.akpm@osdl.org>
In-Reply-To: <20060322155122.2745649f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> So it's that time again.  We need to decide which of the queued sched
> patches should be merged into 2.6.17.
> 
> I have:
> 
> sched-fix-task-interactivity-calculation.patch
> small-schedule-microoptimization.patch
> #
> sched-implement-smpnice.patch
> sched-smpnice-apply-review-suggestions.patch
> sched-smpnice-fix-average-load-per-run-queue-calculations.patch
> sched-store-weighted-load-on-up.patch
> sched-add-discrete-weighted-cpu-load-function.patch
> sched-add-above-background-load-function.patch
> # Suresh had problems

I really need to review smpnice. I'll try to get on to that soon.
I don't have any problems with the non-multiprocessor stuff
(Con's and Mike's patches).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
