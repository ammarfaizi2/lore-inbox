Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbREHUR1>; Tue, 8 May 2001 16:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135263AbREHURH>; Tue, 8 May 2001 16:17:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25094 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135256AbREHURA>;
	Tue, 8 May 2001 16:17:00 -0400
Date: Tue, 8 May 2001 22:16:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20010508221643.T505@suse.de>
In-Reply-To: <20010508220643.S505@suse.de> <Pine.LNX.3.95.1010508161252.29954A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010508161252.29954A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, May 08, 2001 at 04:15:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08 2001, Richard B. Johnson wrote:
> > Use a kernel thread? If you don't need to access user space, context
> > switches are very cheap.
> > 
> > > So, what am I supposed to do to add a piece of driver code to the
> > > run queue so it gets scheduled occasionally?
> > 
> > Several, grep for kernel_thread.
> > 
> > -- 
> > Jens Axboe
> > 
> 
> Okay. Thanks. I thought I would have to do that too. No problem.

A small worker thread and a wait queue to sleeep on and you are all set,
10 minutes tops :-)

> It's a "tomorrow" thing. Ten hours it too long to stare at a
> screen.

Sissy!

-- 
Jens Axboe

