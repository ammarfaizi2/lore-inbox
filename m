Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVANDy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVANDy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVANDyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:54:25 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:18636 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261899AbVANDwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:52:01 -0500
Message-Id: <200501140351.j0E3pdpe027121@localhost.localdomain>
To: Con Kolivas <kernel@kolivas.org>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 14 Jan 2005 14:38:00 +1100."
             <41E73E98.8070603@kolivas.org> 
Date: Thu, 13 Jan 2005 22:51:39 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.152.253.251] at Thu, 13 Jan 2005 21:52:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> its a fine answer, but its the answer to a slightly different
>> question. if anyone (maybe us audio freaks, maybe someone else) comes
>> up with a reason to want "The Real SCHED_FIFO", the original question
>> will have gone unanswered.
>
>Ah then  you missed something. You can set the max cpu of SCHED_ISO to 
>100% and then you have it.

true, i missed that :) but i also recall you saying you were thinking
of having no prioritization within SCHED_ISO ... or am i remembering
wrong? also, is it just me, or having to ways to achieve the exact
same result seems very un-linux-like ... and if they are not exact
same results, how does a regular user get the SCHED_FIFO ones? is the
answer just "they don't" ?

--p
