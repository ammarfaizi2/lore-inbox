Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131765AbQKJXOU>; Fri, 10 Nov 2000 18:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131803AbQKJXOK>; Fri, 10 Nov 2000 18:14:10 -0500
Received: from natted.Sendmail.COM ([63.211.143.38]:14182 "EHLO
	wiz.Sendmail.COM") by vger.kernel.org with ESMTP id <S131765AbQKJXOC>;
	Fri, 10 Nov 2000 18:14:02 -0500
Date: Fri, 10 Nov 2000 15:12:32 -0800
From: Claus Assmann <sendmail+ca@sendmail.org>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, root@chaos.analogic.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        sendmail-bugs@sendmail.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110151232.A16552@sendmail.com>
Reply-To: sendmail-bugs@sendmail.org
In-Reply-To: <3A0C5EDC.3F30BE9C@timpanogas.org> <Pine.LNX.4.21.0011110113590.6465-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0011110113590.6465-100000@server.serve.me.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000, Igmar Palsenberg wrote:
> 
> > > It ran out of memory. The file got sent fine after I got rid of
> > > all the memory-consumers. Looks like a sendmail bug where they
> > > expect to load a whole file into memory all at once before sending
> > > it. I always thought you could read from a file, then write to

As I wrote before: this is just wrong. sendmail doesn't
load the file into memory.

> > > a socket. Maybe I'm old fashioned.
> 
> Sending a 50 MB file is OK here. So it's not a TCP/IP bug. 

Ok, hopefully this reaches everyone who has been "involved"
by Jeff into this "problem".

It turned out that this was just a misconfiguration on his box
(the load average exceeded the limit of his sendmail).

Can we please close this case now? Thanks.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
