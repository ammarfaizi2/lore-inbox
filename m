Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSFTRe2>; Thu, 20 Jun 2002 13:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSFTRe1>; Thu, 20 Jun 2002 13:34:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41175 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315210AbSFTRe0>;
	Thu, 20 Jun 2002 13:34:26 -0400
Date: Thu, 20 Jun 2002 19:31:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
In-Reply-To: <20020620172059.GW22961@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0206201929310.9805-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jun 2002, William Lee Irwin III wrote:

> On Thu, Jun 20, 2002 at 01:47:29AM +0200, Dave Jones wrote:
> > I'll take a look at this tomorrow, unless William "no sleep `til 2.6" Irwin
> > beats me to it 8-)  (he did this part of the patch iirc).
> 
> How does this look? (compiles, boots, & runs on UP i386)

looks good to me - what do you think about my other pidhash suggestion:

> And i'm not quite sure whether it's needed to expose the pidhash to the
> rest of the kernel - it would be much simpler to have it in
> kernel/fork.c locally, and find_task_by_pid() would be a function
> instead of an inline. (it has a ~49 bytes footprint on x86, it's rather
> heavy i think.)

	Ingo



