Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVCaMDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVCaMDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVCaMDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:03:18 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:57570 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261377AbVCaMDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:03:15 -0500
Date: Thu, 31 Mar 2005 13:03:00 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <20050331110330.GA24842@elte.hu>
Message-Id: <Pine.OSF.4.05.10503311301210.11827-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Ingo Molnar wrote:

> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Well, here it finally is. There's still things I don't like about it. 
> > But it seems to work, and that's the important part.
> > 
> > I had to reluctantly add two items to the task_struct.  I was hoping 
> > to avoid that. But because of race conditions it seemed to be the only 
> > way.
> 
> well it's not a big problem, and we avoided having to add flags to the 
> rt_lock structure, which is the important issue.
> 
I was going to say the opposit. I know that there are many more rt_locks
locks around and the fields thus will take more memory when put there but
I believe it is more logical to have the fields there.

Esben

