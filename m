Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136460AbREIN7Z>; Wed, 9 May 2001 09:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136461AbREIN7P>; Wed, 9 May 2001 09:59:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54401 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136460AbREIN7F>; Wed, 9 May 2001 09:59:05 -0400
Date: Wed, 9 May 2001 09:59:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jens Axboe <axboe@suse.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20010508221643.T505@suse.de>
Message-ID: <Pine.LNX.3.95.1010509095722.8944A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Jens Axboe wrote:

> On Tue, May 08 2001, Richard B. Johnson wrote:
> > > Use a kernel thread? If you don't need to access user space, context
> > > switches are very cheap.
> > > 
> > > > So, what am I supposed to do to add a piece of driver code to the
> > > > run queue so it gets scheduled occasionally?
> > > 
> > > Several, grep for kernel_thread.
> > > 
> > > -- 
> > > Jens Axboe
> > > 
> > 
> > Okay. Thanks. I thought I would have to do that too. No problem.
> 
> A small worker thread and a wait queue to sleeep on and you are all set,
> 10 minutes tops :-)
> 
> > It's a "tomorrow" thing. Ten hours it too long to stare at a
> > screen.
> 
> Sissy!
> 

Okay. I am now awake. I will now try the kernel thread. Looks
simple. Got to remember to kill it before/during module removal.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


