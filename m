Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270908AbUJVJhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270908AbUJVJhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270934AbUJVJfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:35:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51619 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270932AbUJVJbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:31:36 -0400
Date: Fri, 22 Oct 2004 11:31:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022093103.GQ1820@suse.de>
References: <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com> <20041022085928.GK1820@suse.de> <20041022090637.GA24523@nietzsche.lynx.com> <20041022090938.GB24523@nietzsche.lynx.com> <20041022092058.GO1820@suse.de> <20041022092404.GA24605@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022092404.GA24605@nietzsche.lynx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22 2004, Bill Huey wrote:
> On Fri, Oct 22, 2004 at 11:20:59AM +0200, Jens Axboe wrote:
> > I've been as clear as I know how on the matter of semaphore use in
> > Linux. I've made no comments at all on improving your deadlock
> > detection scheme.
> 
> True, but "...deadlock detection breaks" is a negative comment about
> the deadlock detector without a positive suggestion to change it, is
> it not ? if so, then suggest a change to be made and it'll get
> implementated somehow.

It's a statement about the deadlock detection which is true, it's not a
negative comment. A negative comment would be something ala "the
deadlock detection code is crap". Note, to avoid further confusion in
this thread: I have not read the deadlock detection code, nor do I
intend to. The sentence is only an example of what a negative comment
would look like, in no way does it reflect my view of the deadlock
detection code. End disclaimer.

As I said, I have no personal motivation to work on the deadlock
detection. My interest in the thread pertained only to code in the
kernel and its use of semaphores - something that we already cleared up
many mails ago.

So, please, lets just end it here. This branch of the thread has already
dragged on for way too long.

-- 
Jens Axboe

