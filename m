Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbUAQPZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 10:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbUAQPZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 10:25:22 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:52388
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S266083AbUAQPZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 10:25:19 -0500
Message-ID: <400953B9.3090900@tmr.com>
Date: Sat, 17 Jan 2004 10:24:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X 
References: Your message of "Fri, 16 Jan 2004 19:10:47 +0100."             <20040116181047.GA1896@elf.ucw.cz> <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu>
In-Reply-To: <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> A better bet would be a patch that allowed you to set the maximum RSS size for
> the process so it can basically thrash itself while leaving enough memory for
> everybody else (and yes, I *know* how this can be self-defeating if the
> thrashing app then increases the total I/O consumed to be higher than the I/O
> bandwidth available - the point is that it's probably the high RSS value for
> his application causing OTHER things to thrash that's the root cause of his
> performance problem).

Or you could use "ulimit -m" to set the RSS, of course.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
