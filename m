Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131450AbQKJXHL>; Fri, 10 Nov 2000 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131577AbQKJXHA>; Fri, 10 Nov 2000 18:07:00 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:16424 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131515AbQKJXGz>; Fri, 10 Nov 2000 18:06:55 -0500
Date: Sat, 11 Nov 2000 01:14:43 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: root@chaos.analogic.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, sendmail-bugs@sendmail.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <3A0C5EDC.3F30BE9C@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011110113590.6465-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It ran out of memory. The file got sent fine after I got rid of
> > all the memory-consumers. Looks like a sendmail bug where they
> > expect to load a whole file into memory all at once before sending
> > it. I always thought you could read from a file, then write to
> > a socket. Maybe I'm old fashioned.

Sending a 50 MB file is OK here. So it's not a TCP/IP bug. 

> Claus,
> 
> Looks like your bug.  As an FYI, sendmail.rpms in Suse, RedHat, and
> OpenLinux all exhibit this behavior, which means they're all broken. 
> Reading an entire file into memory must be a BSD feature.  I have
> enabled an SSH account for you, so you can come in and debug.  Richard
> also can get in and will be helping.
> 
> Jeff



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
