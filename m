Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRFYTKH>; Mon, 25 Jun 2001 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbRFYTJ5>; Mon, 25 Jun 2001 15:09:57 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:46763 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S264303AbRFYTJn>;
	Mon, 25 Jun 2001 15:09:43 -0400
Date: Mon, 25 Jun 2001 20:10:19 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Jeff Dike <jdike@karaya.com>
cc: Bulent Abali <abali@us.ibm.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state 
In-Reply-To: <200106251705.MAA02325@ccure.karaya.com>
Message-ID: <Pine.LNX.4.30.0106252003150.25937-100000@cyrix.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

i have been looking at it a lot over the past few days i seem to be the
person who can trigger it easyest.

over the past couple of days i have been running with the
#define WAITQUEUE_DEBUG 1
no problems seem to have appeared there though and the bug still triggers.

On Mon, 25 Jun 2001, Jeff Dike wrote:

> abali@us.ibm.com said:
> > I am running in to a problem, seemingly a deadlock situation, where
> > almost all the processes end up in the TASK_UNINTERRUPTIBLE state.
> > All the process eventually stop responding, including login shell, no
> > screen updates, keyboard etc.  Can ping and sysrq key works.   I
> > traced the tasks through sysrq-t key.  The processors are in the idle
> > state.  Tasks all seem to get stuck in the __wait_on_page or
> > __lock_page.

i also seem to get ut ub __wait_on_buffer and ___wait_on_page

	James
-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  8:00pm  up 2 days, 12 min,  4 users,  load average: 1.41, 0.38, 0.40

