Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTEaTqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTEaTqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:46:43 -0400
Received: from BELLINI.MIT.EDU ([18.62.3.197]:24068 "EHLO bellini.mit.edu")
	by vger.kernel.org with ESMTP id S264537AbTEaTqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:46:40 -0400
Date: Sat, 31 May 2003 16:00:20 -0400 (EDT)
From: ghugh Song <ghugh@bellini.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Something wrong with recent 2.4.21-rc* kernels?
Message-ID: <Pine.LNX.4.53.0305311553350.2945@bellini.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am comparing
>
> 2.4.21-pre3-ac4
> 2.4.21-rc5-ac1
> 2.4.21-rc6-ac1
>
> In the last two kernels, something is definitely not right.
> LaTeXing a big file takes about twice the time compared to
> the same job under 2.4.21-pre3-ac4.
> However, I am not totally satisfied with the 2.4.21-pre3-ac4, either.
> In the beginning just after a reboot, the condition is really nice.
> However, after a while, "time"ing a job reveals that something bad is
> happening in the first column of "real" time, which means the wall-clock
> timing. One might say that it is still better with 2.4.21-pre3-ac4
> than the situation with 2.4.21-rc5-ac1 or with 2.4.21-rc6-ac1, because
> it still does not contaminate "user" time in the middle column.

I am pleased to report that the problem has been solved by
Rick's RMap15j.  So, I am now running
2.4.21-rc6-rmap15j.

Relevant information can be found at
http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1850.html

If anyone is having the same problem, please take a note.

Regards,


G. Hugh Song


