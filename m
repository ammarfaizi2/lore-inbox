Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272433AbTGZJb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 05:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272439AbTGZJb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 05:31:58 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:58381 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272433AbTGZJb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 05:31:56 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sat, 26 Jul 2003 11:46:45 +0200
User-Agent: KMail/1.5.2
Cc: kernel@kolivas.org, mingo@elte.hu
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307261142.43277.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 11:30, Felipe Alfaro Solana wrote:

Hi Felipe,

> I just only wanted to publicly invite Con Kolivas to keep on working
> with the scheduler patches he has been doing and that have required a
> constant and fair amount of time from him. I don't know if Con patches
> do work as good for others in this list as for me, so I also invite
> everyone who is/has been testing them to express their feelings so we
> all can know what's the current status of the 2.6 scheduler.
For me, all the Oxint Scheduler patches won't work well. Even for O8int I can 
say the same as for 01int to 07int, the system is dog slow when doing "make 
-j2 bzImage modules". XMMS does not skip, but hey, I don't care about XMMS 
skipping at all. I want a system which is responsive under heavy load, where 
opening an new xterm does not take 5-10 seconds, or writing an email in my MUA 
looks like a child is writing on a typewriter with one finger ;)

Now that I've tested 2.6.0-test-1-wli (William Lee Irwin's Tree) for over a 
week, I thought about, that the problem might _not_ be only the O(1) 
Scheduler, because -wli has changed almost nothing to the scheduler stuff, 
it's almost 2.6.0-test1 code and running that kernel, my system is _alot_ 
more responsive than 2.6.0-test1 or 2.6.0-test1-mm* or all the Oxint 
scheduler fixes have ever been.

Strange no?

P.S.: I've not tested Ingo's G3 scheduler fix yet. More to come.

ciao, Marc

