Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRAaBlA>; Tue, 30 Jan 2001 20:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRAaBku>; Tue, 30 Jan 2001 20:40:50 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:48823 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130461AbRAaBkf>;
	Tue, 30 Jan 2001 20:40:35 -0500
Date: Tue, 30 Jan 2001 20:39:42 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to
 do with ECN)
In-Reply-To: <Pine.LNX.4.30.0101310213400.13467-100000@elte.hu>
Message-ID: <Pine.GSO.4.30.0101302037080.3017-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Jan 2001, Ingo Molnar wrote:

>
> On Tue, 30 Jan 2001, jamal wrote:
>
> > > - is this UDP or TCP based? (UDP i guess)
> > >
> > TCP
>
> well then i'd suggest to do:
>
> 	echo 100000 100000 100000 > /proc/sys/net/ipv4/tcp_wmem
>
> does this make any difference?

According to my notes, i dont see this.
however, 262144 into /proc/sys/net/core/*mem_max/default.

I have access to my h/ware this weekend. Hopefully i should get something
better than ttcp to use.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
