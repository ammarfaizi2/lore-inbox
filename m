Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRLBQdT>; Sun, 2 Dec 2001 11:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281128AbRLBQbu>; Sun, 2 Dec 2001 11:31:50 -0500
Received: from [195.63.194.11] ([195.63.194.11]:13580 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280814AbRLBQbU>; Sun, 2 Dec 2001 11:31:20 -0500
Message-ID: <3C0A54F4.C70C815C@evision-ventures.com>
Date: Sun, 02 Dec 2001 17:21:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Larry McVoy <lm@bitmover.com>, Davide Libenzi <davidel@xmailserver.org>,
        Andrew Morton <akpm@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16A75O-0006hY-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Wasn't it you that were saying that Linux will never scale with more than
> > > 2 CPUs ?
> >
> > No, that wasn't me.  I said it shouldn't scale beyond 4 cpus.  I'd be pretty
> > lame if I said it couldn't scale with more than 2.  Should != could.
> 
> Question: What happens when people stick 8 threads of execution on a die with
> a single L2 cache ?

That had been already researched. Gogin bejoind 2 threads on a single
CPU
engine doesn't give you very much... The first step is giving about 25%
the second only about 5%. There are papers in the IBM research magazine
on
this topic in context of the PowerPC.
