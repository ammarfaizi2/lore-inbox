Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289936AbSAQXKP>; Thu, 17 Jan 2002 18:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289949AbSAQXKG>; Thu, 17 Jan 2002 18:10:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:21765 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289936AbSAQXJ6>;
	Thu, 17 Jan 2002 18:09:58 -0500
Subject: Re: [PATCH] 2.5.3-pre1 ata-253p1-2
From: Robert Love <rml@tech9.net>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 18:13:35 -0500
Message-Id: <1011309216.2668.205.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 17:59, Andre Hedrick wrote:

> This kernel is totally ACB-IO or Taskfile Driven, the Config.in Option is
> to allow user-space access for diagnostics, forensics and OEM feature
> sets.

Oh, OK -- 2.5.3-pre1 doesn't have Configure.help entries ;)
But I think Anton sent them, so hopefully we will see them.

I guess the configure option just enables the ioctl, then, eh?  Gotcha.

> You have to give Jens the credit for gluing it togather, because there was
> no way I would have figured out the suttle issues of BIO.  There are
> serveral additions need to fix all the archs so hope to have something
> today.

Well, good work to both of you.  It is an excellent driver.  Please
submit it for pre2.

FYI, I am having no problems with the above and preempt-kernel, which
I've heard reported otherwise.  If it works with preemption and SMP ...

	Robert Love

