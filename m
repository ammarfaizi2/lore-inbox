Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316741AbSERBxH>; Fri, 17 May 2002 21:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316743AbSERBxG>; Fri, 17 May 2002 21:53:06 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:35481 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316741AbSERBxF>; Fri, 17 May 2002 21:53:05 -0400
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question : Broadcast Inter Process Communication ?
In-Reply-To: <20020517143052.A30047@bougret.hpl.hp.com>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Sat, 18 May 2002 03:52:33 +0200
Message-ID: <873cwqrzmm.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

Jean Tourrilhes <jt@bougret.hpl.hp.com> writes:

> 	I was looking under Linux for a mechanism to distribute an
> event from one process (a daemon) to a set of other processes (deamons
> or applications). The number and indentity of those other processes
> would not be known by the process generating the event, those
> processes would register themselves dynamically to the stream of
> event. And the event need to be delivered to all of them (not only the
> first one).
> 	In other words, it would look like a *broadcast* message
> queue, where the sender process would create the queue and write
> events to it, and the other bunch of processes would dynamically open
> the queue and listen for events.

[snip]

> 	This "one sender - multiple reader" model seems common and
> usefull enough that there must be a way to do that under Linux. I know
> that it exist under Windows. Can somebody help me to find out how to
> do it under Linux ?


Maybe, you're looking for multicast. But you need a TCP/IP stack for
this and I don't know, wether this is implemented in Linux.

Regards, Olaf.
