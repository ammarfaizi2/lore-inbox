Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWAHVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWAHVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWAHVt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:49:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62086 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965028AbWAHVt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:49:28 -0500
Date: Sun, 8 Jan 2006 22:49:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
cc: Mark Knecht <markknecht@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
In-Reply-To: <43C17E50.4060404@stud.feec.vutbr.cz>
Message-ID: <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
 <43C17E50.4060404@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi,
>>   I did run across a way that I can create a repeatable xrun on my
>> AMD64 machine by burning a CD in k3b while Jack is running.
>> Unfortunately I do not see any good trace data in dmesg when I do it.
>
> Maybe your cdrecord is running with realtime priority higher than Jack?
> Michal

cdrecord does run with SCHED_RR/99 when started with proper privileges.


Jan Engelhardt
-- 
