Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbQKJVAX>; Fri, 10 Nov 2000 16:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131405AbQKJVAD>; Fri, 10 Nov 2000 16:00:03 -0500
Received: from natted.Sendmail.COM ([63.211.143.38]:45108 "EHLO
	wiz.Sendmail.COM") by vger.kernel.org with ESMTP id <S130425AbQKJU77>;
	Fri, 10 Nov 2000 15:59:59 -0500
Date: Fri, 10 Nov 2000 12:59:02 -0800
From: Claus Assmann <sendmail+ca@sendmail.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: root@chaos.analogic.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, sendmail-bugs@sendmail.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110125902.A16027@sendmail.com>
Reply-To: sendmail-bugs@sendmail.org
In-Reply-To: <Pine.LNX.3.95.1001110153916.6334A-100000@chaos.analogic.com> <3A0C5EDC.3F30BE9C@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A0C5EDC.3F30BE9C@timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000, Jeff V. Merkey wrote:

> "Richard B. Johnson" wrote:

> > It ran out of memory. The file got sent fine after I got rid of
> > all the memory-consumers. Looks like a sendmail bug where they
> > expect to load a whole file into memory all at once before sending
> > it. I always thought you could read from a file, then write to

On which evidence do you base this idea?

> > a socket. Maybe I'm old fashioned.

Yeah, just like us.

Please provide some proof to your claims.


> Looks like your bug.  As an FYI, sendmail.rpms in Suse, RedHat, and
> OpenLinux all exhibit this behavior, which means they're all broken. 

Sorry, this is plain wrong. sendmail does NOT read the entire
file into memory.

> Reading an entire file into memory must be a BSD feature.  I have
> enabled an SSH account for you, so you can come in and debug.  Richard
> also can get in and will be helping.

What's the machine name and what's the account?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
