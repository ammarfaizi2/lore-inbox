Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTFLLa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264753AbTFLLa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:30:28 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:3067 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264722AbTFLLa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:30:27 -0400
Date: Thu, 12 Jun 2003 23:47:16 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: implicid declaration of function task_suspended - Was:	[PATCHSET]
 2.4.21-rc6-dis3 released
In-reply-to: <1055410660.3ee849e439b96@support.tuxbox.dk>
To: Martin List-Petersen <martin@list-petersen.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@gotontheinter.net
Message-id: <1055418435.17838.8.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1055410660.3ee849e439b96@support.tuxbox.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TASK_SUSPENDED is a swsusp macro. What version of swsusp do you have
included in your kernel? (There were some compile problems fixed a while
ago - you probably have a version pre then).

Regards,

Nigel

On Thu, 2003-06-12 at 21:37, Martin List-Petersen wrote:
> I tried to compile this (both on rc6 and rc7) and the compile fails with:
> 
> kernel/kernel.o(.text+0x2d8): In function 'schedule':
> : undefined reference to 'TASK_SUSPENDED'
> kernel/kernel.o(.text+0x392): In function 'schedule':
> : undefined reference to 'TASK_SUSPENDED'
> 
> The compile allready stated in the beginning:
> sched.c: In function 'schedule':
> sched.c:611: implicit declaration of function 'TASK_SUSPENDED'
> 
> Any idea's what i can leave out to avoid these failures ?
> 
> Regards,
> Martin List-Petersen
> martin at list-petersen dot dk
> --
> Q:	What do you get when you cross the Godfather with an attorney?
> A:	An offer you can't understand.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

