Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268519AbTBNX4t>; Fri, 14 Feb 2003 18:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268526AbTBNX4t>; Fri, 14 Feb 2003 18:56:49 -0500
Received: from mail.zmailer.org ([62.240.94.4]:42390 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S268519AbTBNX4k>;
	Fri, 14 Feb 2003 18:56:40 -0500
Date: Sat, 15 Feb 2003 02:06:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215000628.GB1073@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com> <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 04:00:03PM -0800, Davide Libenzi wrote:
> On Thu, 13 Feb 2003, Linus Torvalds wrote:
....
> > > > One of the reasons for the "flags" field (which is not unused) was because
> > > > I thought it might have extensions for things like alarms etc.
> > > I was thinking more like :
> > > 
> > > int timerfd(int timeout, int oneshot);
> >
> > It could be a separate system call, ...
> 
> I would personally like it a lot to have timer events available on
> pollable fds. Am I alone in this ?

Somehow all this idea has a feeling of long established
Linux kernel facility called:  netlink

It can send varying messages to userspace via a file-handle, and is 
pollable.  Originally that is for network codes, and therefore it
already has protocol capable to handle multiple different formats,
handle queue saturation, etc.

Do we need new syscall(s) ?  Could it all be done with netlink ?

/Matti Aarnio
