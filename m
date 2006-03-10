Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWCJWCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWCJWCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWCJWCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:02:42 -0500
Received: from main.gmane.org ([80.91.229.2]:12782 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751429AbWCJWCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:02:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
Date: Fri, 10 Mar 2006 22:01:58 +0000
Message-ID: <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
References: <441180DD.3020206@wpkg.org> <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:t6YH8Yd+WwTSG9/Uu8q4onVXyas=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>Subject: can I bring Linux down by running "renice -20
>>cpu_intensive_process"?
>>
> Depends on what the cpu_intensive_process does. If it tries to allocate 
> lots of memory, maybe. If it's _just_ CPU (as in `perl -e '1 while 1'`), 
> you get a chance that you can input some commands on a terminal to kill it.
> SCHED_FIFO'ing or SCHED_RR'ing such a process is sudden death of course.

Sysrq+n changes all realtime tasks to normal priority.

-- 
Måns Rullgård
mru@inprovide.com

