Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWCLMAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWCLMAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 07:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCLMAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 07:00:21 -0500
Received: from [82.153.166.94] ([82.153.166.94]:12519 "EHLO mail.inprovide.com")
	by vger.kernel.org with ESMTP id S1751423AbWCLMAU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 07:00:20 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
References: <441180DD.3020206@wpkg.org>
	<Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	<yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
	<1142135077.25358.47.camel@mindpipe>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sun, 12 Mar 2006 12:00:09 +0000
In-Reply-To: <1142135077.25358.47.camel@mindpipe> (Lee Revell's message of "Sat, 11 Mar 2006 22:44:36 -0500")
Message-ID: <yw1xk6azdgae.fsf@agrajag.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Fri, 2006-03-10 at 22:01 +0000, Måns Rullgård wrote:
>> Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>> 
>> >>Subject: can I bring Linux down by running "renice -20
>> >>cpu_intensive_process"?
>> >>
>> > Depends on what the cpu_intensive_process does. If it tries to
>> > allocate lots of memory, maybe. If it's _just_ CPU (as in `perl
>> > -e '1 while 1'`), you get a chance that you can input some
>> > commands on a terminal to kill it.  SCHED_FIFO'ing or
>> > SCHED_RR'ing such a process is sudden death of course.
>> 
>> Sysrq+n changes all realtime tasks to normal priority.
>> 
>
> A nice -20 SCHED_OTHER task is not realtime, only SCHED_FIFO and
> SCHED_RR.

Maybe extending sysrq+n to lower the priority of -20 tasks would be a
good idea.

-- 
Måns Rullgård
mru@inprovide.com
