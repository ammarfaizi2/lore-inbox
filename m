Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWCQIXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWCQIXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWCQIW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:22:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30396 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964933AbWCQIWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:22:32 -0500
Date: Fri, 17 Mar 2006 09:20:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Brown <dmlb2000@gmail.com>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.16-rc6-rt7
Message-ID: <20060317082002.GA7922@elte.hu>
References: <20060316095607.GA28571@elte.hu> <9c21eeae0603160939sa48bbe7i84698c8a2187ae4@mail.gmail.com> <1142531421.29968.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142531421.29968.28.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2006-03-16 at 09:39 -0800, David Brown wrote:
> > I've been having issues with the realtime patch set and using scp
> > (specifically scp, wget, curl, git, cvs everything else works fine). I
> > was wondering what extra debugging features are helpful to have built
> > into the kernel that could help me nail down why this bug is
> > happening.
> > 
> > Specifically what's happening is scp is freezing my system, there
> > haven't been any kernel warnings or panics upon execution of scp, it
> > just freezes, every other application that uses network seems to work
> > just fine, so far it's just been scp.
> 
> Just found a problem in the highres timer merge. Can you try the patch 
> below?

i have released -rt8 with this fix included.

	Ingo
