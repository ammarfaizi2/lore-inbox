Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316910AbSFQSA3>; Mon, 17 Jun 2002 14:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSFQSA2>; Mon, 17 Jun 2002 14:00:28 -0400
Received: from isolaweb.it ([213.82.132.2]:5137 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S316910AbSFQSAZ>;
	Mon, 17 Jun 2002 14:00:25 -0400
Message-Id: <5.1.1.6.0.20020617195647.036a9d40@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 17 Jun 2002 20:00:06 +0200
To: Marco Colombo <marco@esi.it>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206171755340.1449-100000@Megathlon.ESI>
References: <5.1.1.6.0.20020617094803.00a96bd0@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18.07 17/06/02 +0200, Marco Colombo wrote:

>On Mon, 17 Jun 2002, Roberto Fichera wrote:
>
>[...]
> > process to a CPU. But I continue to not hunderstand why
> > I must have only one thread per CPU. There is some URL
> > where can I see some kernel/sched/vm/I-O/other-think graph about
> > this point ?
>
>To put it simply, because you have only one PC per CPU. It's not
>really an OS thing.
>
>Every time you're saving the PC (and SP, and all the "thread context")
>you're "emulating" more CPUs on just one. And what you got is just...
>an emulation. A Thread is an execution abstraction, and a CPU is an
>execution actor. Sounds sensible to match the two. Use functions instead
>to group instructions by their (functional) meaning.

Yes! I know ;-)!

>It makes much more sense, on 4-ways system, to have 4 rather complex
>threads that are able to execute different functions, like in
>a data-driven or event-driven model, than to run 400 simpler threads
>which implement one function each, IMHO.

To make it simple, I'll try the 2 solutions!


>.TM.

Roberto Fichera.

