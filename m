Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVANDgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVANDgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVANDeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:34:01 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:27041 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261889AbVANDae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:30:34 -0500
Message-Id: <200501140330.j0E3UCiG027037@localhost.localdomain>
To: Con Kolivas <kernel@kolivas.org>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 14 Jan 2005 14:18:12 +1100."
             <41E739F4.1030902@kolivas.org> 
Date: Thu, 13 Jan 2005 22:30:12 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.152.253.251] at Thu, 13 Jan 2005 21:30:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Paul.  Everyone agrees with you.  I think.  We just need to work out
>> the best way of doing it.
>> 
>> Would I be right in suspecting that we know what to do, but nobody has
>> stepped up to write the code?  It's kinda looking like that?
>
>I thought I made it clear i had already volunteered. I was after a 
>response to my proposal for how to do it.

I think your proposal is a good (maybe even excellent) one, but it
somewhat sidesteps the issue (which may be the best thing to
do). Rather than answering the question "how best to allow regular
users access to SCHED_FIFO", it says "lets offer regular users
SCHED_ISO which is essentially identical to SCHED_FIFO unless tasks
running SCHED_ISO use too much cpu time".

its a fine answer, but its the answer to a slightly different
question. if anyone (maybe us audio freaks, maybe someone else) comes
up with a reason to want "The Real SCHED_FIFO", the original question
will have gone unanswered.

--p
