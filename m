Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281624AbRLAMYB>; Sat, 1 Dec 2001 07:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281631AbRLAMXv>; Sat, 1 Dec 2001 07:23:51 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:55704 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S281638AbRLAMXb> convert rfc822-to-8bit; Sat, 1 Dec 2001 07:23:31 -0500
Date: Sat, 1 Dec 2001 10:30:04 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Davide Libenzi <davidel@xmailserver.org>,
        Andrew Morton <akpm@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16A75O-0006hY-00@the-village.bc.nu>
Message-ID: <20011201101518.K1442-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Dec 2001, Alan Cox wrote:

> > > Wasn't it you that were saying that Linux will never scale with more than
> > > 2 CPUs ?
> >
> > No, that wasn't me.  I said it shouldn't scale beyond 4 cpus.  I'd be pretty
> > lame if I said it couldn't scale with more than 2.  Should != could.
>
> Question: What happens when people stick 8 threads of execution on a die with
> a single L2 cache ?

As long as we will not have clean asynchronous mechanisms available from
user land, some applications will have to use more threads of execution
than needed, even with programmers that aren't thread-maniac.

Response to your question: If the problem is to optimize IOs against 8
slow devices using synchronous IO APIs , you will get far better
performances. :-)

  Gérard.


