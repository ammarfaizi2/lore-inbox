Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTAWImd>; Thu, 23 Jan 2003 03:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAWImd>; Thu, 23 Jan 2003 03:42:33 -0500
Received: from posti2.jyu.fi ([130.234.4.33]:26242 "EHLO posti2.jyu.fi")
	by vger.kernel.org with ESMTP id <S265066AbTAWImc>;
	Thu, 23 Jan 2003 03:42:32 -0500
Date: Thu, 23 Jan 2003 10:51:33 +0200 (EET)
From: Riku Meskanen <mesrik@cc.jyu.fi>
To: <redhat-devel-list@redhat.com>
cc: <redhat-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux application level timers?
In-Reply-To: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0301231044560.27340-100000@tukki.cc.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Tom Sanders wrote:

> I'm writing an application server which receives
> requests from other applications. For each request
> received, I want to start a timer so that I can fail
> the application request if it could not be completed
> in max specified time.
>
> Which Linux timer facility can be used for this?
>
> I have checked out alarm() and signal() system calls,
> but these calls doesn't take an argument, so its not
> possible to associate application request with the
> matured alarm.
>
> Any inputs?
>
Yes, get a book like "Advanced Programming in
the UNIX Environment" W. Richard Stevens and
look how to use signals and select()/poll()
from there.

Also if you are able to use tools to have the
protocol defined by ASN.1 that would help, because
then you could be able to have tools to generate
automatically protocol handling code too with C or
C++ etc.

I'm not in the latter business, read and used
some code from the above book long time ago,
but I've seen nice tools used more and more rather
than hand-coding the protocol (because it's very
easy get in troubles with hard to find errors
of incomplete state-machine etc.)

HTH,

:-) riku

-- 
    [ This .signature intentionally left blank ]

