Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264598AbRFSSHv>; Tue, 19 Jun 2001 14:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRFSSHl>; Tue, 19 Jun 2001 14:07:41 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:65033 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264598AbRFSSHb>; Tue, 19 Jun 2001 14:07:31 -0400
Date: 19 Jun 2001 20:01:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <838x7gT1w-B@khms.westfalen.de>
In-Reply-To: <20010619090956.R3089@work.bitmover.com>
Subject: Re: Alan Cox quote?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3B2F769C.DCDB790E@kegel.com> <dank@kegel.com> <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca> <3B2F769C.DCDB790E@kegel.com> <20010619090956.R3089@work.bitmover.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lm@bitmover.com (Larry McVoy)  wrote on 19.06.01 in <20010619090956.R3089@work.bitmover.com>:

> Another one that I can't believe I forgot is from Rob Pike:
>
>     "If you think you need threads then your processes are too fat"
>
> And one from me:
>
>     ``Think of it this way: threads are like salt, not like pasta. You
>     like salt, I like salt, we all like salt. But we eat more pasta.''
>
> Threads are a really bad idea.  All you need are processes and either the
> ability to not fork the VM (Linux' clone, Plan 9's rfork) or just good
> old mmap(2).  If you allow threads then all you are saying is that your
> process model is so pathetic you had to invent another, supposedly lighter
> weight, object to do the same thing.

The funny thing here, Larry, is that to most people (who aren't OS gurus),  
Linux' clone or Plan 9's rfork *are* threads.

I certainly agree that you don't necessarily need two different kernel- 
level kinds of things, but really, most of the time when people talk about  
threads, they don't care one whit how their libraries manage to produce  
threads, as long as those threads actually work.

Threads are a kind of abstraction.

And the argument that you don't need threads when you have state machines  
is exactly as valid as the one that says that you don't need loops when  
you have goto.

Oh, you also don't need subroutines when you have state machines and goto.  
Fancy that!

I've even been told you can do all these things with nothing more than a  
Turing machine ...

MfG Kai
