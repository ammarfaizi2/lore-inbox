Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJ2XiB>; Sun, 29 Oct 2000 18:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129200AbQJ2Xhw>; Sun, 29 Oct 2000 18:37:52 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:48702 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129063AbQJ2Xhh>; Sun, 29 Oct 2000 18:37:37 -0500
Date: Mon, 30 Oct 2000 01:45:34 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Stephen Harris <sweh@spuddy.mew.co.uk>
cc: pollard@cats-chateau.net, vonbrand@sleipnir.valparaiso.cl,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
In-Reply-To: <200010291718.RAA19325@spuddy.mew.co.uk>
Message-ID: <Pine.LNX.4.21.0010300143490.15335-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It was NOT ignored. If syslogd dies, then the system SHOULD stop, after a
> 
> Huh?  "SHOULD"?   Why?  If syslog dies for any reason (bug, DOS, hack,
> admin stupidity) then I sure don't want the system freezing up.

In some cases, I find the syslog messages of more importance then a
working system. I like to know what's going on on my machines.

> ( heh...  at work on Solaris I monitor 300+ systems, and it's not unusual
> to find 1 box a week with syslog not running for some reason or another.
> I can't decide whether it's admin stupidity or bugs in Solaris syslog - of
> which there are many :-(( )
> 
> syslog is not meant to be a secure audit system.  Messages can be
> legitimately dropped.

I find dropping messages unacceptable.

>   Applications have been coded assuming that they
> will not be frozen in syslog().  Linux should not be different in this
> respect.   Hmm... it might be nice to be this a system tunable parameter
> but I'm not sure the best way of doing that (glibc maybe?)

I needs to be in glibc, yes.

> 
>                                  Stephen Harris


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
