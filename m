Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSH0Q4m>; Tue, 27 Aug 2002 12:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSH0Q4m>; Tue, 27 Aug 2002 12:56:42 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:17168 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316569AbSH0Q4k>;
	Tue, 27 Aug 2002 12:56:40 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271700.g7RH0uq31917@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: <Pine.LNX.4.44.0208271038240.3234-101000@hawkeye.luckynet.adm> from
	Thunder from the hill at "Aug 27, 2002 10:42:26 am"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Tue, 27 Aug 2002 18:57:16 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Thunder from the hill wrote:"
> On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> > > Why so rough?
> > 
> > Rough? You mean "approximate"? I was working from my vague mamory of
> > what I read in the code on the train this morning.
> 
> No, rough. I meant, why not use sys_open()?

You mean do a syscall with flags O_DIRECT from within the driver?
I don't like syscalsl from kernel code, but if you say so, I'll think
about it.

> Certainly not, as I'm not using libc6. But my manpages are newer, the 
> latest version is appended. It might clear this issue to you.

Thanks.

> > Oh, well, thanks.I suppose you won't give me a recipe saying "do this
> > and your device won't be cached", but I'll follow the lead.
> 
> I can't, because I don't have your code here and can't tell your needs. I 
> just try to serve it all. (I mean it all depends not just on where you go, 
> but also on what you have.)

Mmm ..  I must say I don't see how.  Making all requests on a block
device not be cached by VMS seems to me to have a globally defined
semantics, not confined to my particular use or context! Are you
suggesting that it depends on the mode of access to the device? That I
can't control - I simply want ALL accesses to not be cached.

Peter

