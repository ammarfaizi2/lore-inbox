Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135433AbRAHKUr>; Mon, 8 Jan 2001 05:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136540AbRAHKUh>; Mon, 8 Jan 2001 05:20:37 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:31973 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135433AbRAHKUX>; Mon, 8 Jan 2001 05:20:23 -0500
Message-ID: <3A5995CF.7AEFFBBD@uow.edu.au>
Date: Mon, 08 Jan 2001 21:26:23 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Sailer <sailer@bnl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network Performance?
In-Reply-To: <20010104013340.A20552@bnl.gov>, <20010104013340.A20552@bnl.gov>; <20010105140021.A2016@bnl.gov> <3A56FD6C.93D09ABB@uow.edu.au>,
		<3A56FD6C.93D09ABB@uow.edu.au>; from andrewm@uow.edu.au on Sat, Jan 06, 2001 at 10:11:40PM +1100 <20010107235123.B6028@bnl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Sailer wrote:
> 
> On Sat, Jan 06, 2001 at 10:11:40PM +1100, Andrew Morton wrote:
> > this issue was discussed on the netdev mailing list a few weeks
> > back.
> >
> > It's very unfortunate that the web archives of netdev
> > stopped working several months ago and there now appears
> > to be no web archive of netdev@oss.sgi.com.
> >
> > Go to http://oss.sgi.com/projects/netdev/archive/ and
> > pull down the November and December archives.
> >
> > The subject was "linux to solaris tcp issues on WAN".
> >
> > The conclusion was "The problem is also fixed with
> > 2.4.0-test12pre3". Dunno about kernel 2.2 though.
> 
> Well, on Friday, we pulled down the 'official' 2.4.0, and had the
> same experience... nothing better. Should I get the -test12-pre3 kernel
> and try that one specifically?

I doubt if that would help.

I claim no expertise in this area, but perhaps we can
get some protocol gurus interested.

To recap:

You're sending and receiving FTP/TCP/IP4 to Solaris and AIX hosts
You have a 1000kbyte window size
You have an 80 megabit/sec pipe.
You're getting 1.8 megabits/sec.

What is the round-trip time on the WAN?

Packet loss?

Does the problem occur in both directions?

Are you _sure_ the window size is being set correctly? How
is it being set?

Are you able to generate TCP dumps when the problem is happening?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
