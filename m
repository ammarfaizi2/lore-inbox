Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131816AbRA0K6u>; Sat, 27 Jan 2001 05:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbRA0K6k>; Sat, 27 Jan 2001 05:58:40 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56837 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131816AbRA0K6a>; Sat, 27 Jan 2001 05:58:30 -0500
From: Stefani Seibold <stefani@seibold.net>
Date: Sat, 27 Jan 2001 11:57:14 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, Stefani@seibold.net
To: Thunder from the hill <thunder@ngforever.de>
In-Reply-To: <01012612051000.01240@deepthought.seibold.net> <3A7211BB.AF85D0BC@ngforever.de>
In-Reply-To: <3A7211BB.AF85D0BC@ngforever.de>
Subject: Re: patch for 2.4.0 disable printk
MIME-Version: 1.0
Message-Id: <01012711571400.01203@deepthought.seibold.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right... this patch make no sense on a computer system with human 
interactions. But think on tiny hidden computers, like in a dishwasher or a 
traffic light. This computer are standalone, if it crash, then it will be 
rebooted.
Nobody will attach a terminal to this kind of computer, nobody is interessted 
on a logfile. Nobody will see a oops, because nobdy is there. 
The hardware of this computer are espacilly designed and will never be 
changed. It is not like a pc, where many different hardware will be attached.
Believe me, i am programming embedded systems since 10 years... i know this 
buissines.
It is also a fine thing for rescued disk, where you never have enough space 
to put all the tools togetehr which are needed.
And rememberf: It is an option, you should it only use, iof u know what u do, 
like many other building a kernel.

Greetings,
Stefani

> What sense does it make to ripp the kernel off its "tongue"? This means
> to make it completely silent, a oops() could _not_ be noticed! This
> means that you don't know when your system has nearly crashed.
> You'd better leave printk where it is.
>
> Thunder
> ---
> Woah... I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard
> god...
> Stefani Seibold wrote:
> > this kernel patch allows to disable all printk messages, by overloading
> > the printk function with a dummy printk macro.
> >
> > This patch is usefull for embedded systems, where the hardware never
> > changes and normaly no textconsole is attachted nor any user will see the
> > boot messages. Also, it is nice for rescue disks.
> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
