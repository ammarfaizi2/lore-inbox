Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUADEX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUADEX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 23:23:56 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:12672 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265113AbUADEXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 23:23:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Jan 2004 20:23:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040104015037.AE9A62C0AB@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401032019290.2022-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, Rusty Russell wrote:

> Still do.  It's *simple*, and I refuse to be ashamed of that.
> 
> My words were harsh, but I completely disagree with you.  I believe
> you are wrong.  I would never have coded it the way you did.  I read
> your code and I still think you are wrong, and find your code both
> bloated and ugly.

Bloated ? This is the diffstat of my "ashamed" patch over your bits :-)

include/linux/init_task.h |    3 +
include/linux/sched.h     |    8 ++++
kernel/kthread.c          |   78 ++++++++++++++++------------------------------
3 files changed, 39 insertions(+), 50 deletions(-)



> Now, on something we do agree: I dislike the global structure myself.
> By all means try changing the code to use a pipe between child and
> parent for the initfn result.  But I've told you that I will not
> submit any solution which adds to a generic structure for a specific
> problem.
> 
> I'm very, very sorry this has gotten a little heated: I generally
> enjoy our discussions.  But I don't think I should have to say "no"
> four times.

It's ok Rusty, I enjoy the discussion in any case :-) Since I told you in 
a private email that I was convinced myself about adding stuff inside the 
struct, you could have avoided the "ashamed" thing. But it's fine, a 
little bit of sarcasm is the salt of life.




- Davide


