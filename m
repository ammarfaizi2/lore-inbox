Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbRFTWJ5>; Wed, 20 Jun 2001 18:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbRFTWJr>; Wed, 20 Jun 2001 18:09:47 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:14641 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S261515AbRFTWJk>; Wed, 20 Jun 2001 18:09:40 -0400
Message-Id: <4.3.2.7.2.20010620150729.00b60710@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 20 Jun 2001 15:08:52 -0700
To: Martin Devera <devik@cdi.cz>, bert hubert <ahu@ds9a.nl>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: Threads are processes that share more
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10106202036470.10363-100000@luxik.cdi.cz>
In-Reply-To: <20010620175937.A8159@home.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:48 PM 6/20/01 +0200, Martin Devera wrote:
>BTW is not possible to implement threads as subset of process ?
>Like thread list pointed to from task_struct. It'd contain
>thread_structs plus another scheduler's data.
>The thread could be much smaller than process.
>
>Probably there is another problem I don't see, I'm just
>currious whether can it work like this ..

Threads would then run, as a group, at the priority of the process, and 
then by priority within the process thread group.  To be truely useful, 
threads need to be able to have their run priority divorced from the 
priority of the spawning process.

By the way, I'm surprised no one has mentioned that a synonym for "thread" 
is "lightweight process".

Satch

