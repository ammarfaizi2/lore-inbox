Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132277AbRAIXC5>; Tue, 9 Jan 2001 18:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAIXCr>; Tue, 9 Jan 2001 18:02:47 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:34845 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132277AbRAIXCg>; Tue, 9 Jan 2001 18:02:36 -0500
Date: Wed, 10 Jan 2001 01:09:31 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <UTC200101081556.QAA147730.aeb@texel.cwi.nl>
Message-ID: <Pine.LNX.4.21.0101100106280.12970-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 2.2.18 sometimes sees 61 GB, sometimes 32 GB.
> > I don't call that hard to understand.
> 
> The same kernel has varying behaviour?
> Maybe not hard to understand, but rather surprising.
> You are the first to report nondeterministic behaviour.

You're not the only one that is suprised :

1) Put disk in my machine (target machine hangs itself with the disk)
2) use setmax to set the limit to 32 GB
3) Put the disk in the target machine
4) System boots, linux sees 64GB
5) rebooted system, system hangs due to the soft clippig 'vanished'

I even had occurences of the kernel setmax message showing up, and after a
plain reboot it didn't.

It beats me.. I can't explain, and the machine is rock solid now.



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
