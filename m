Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290017AbSA3QhJ>; Wed, 30 Jan 2002 11:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290009AbSA3QeX>; Wed, 30 Jan 2002 11:34:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63108 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290018AbSA3Qdn>; Wed, 30 Jan 2002 11:33:43 -0500
Date: Wed, 30 Jan 2002 11:35:41 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <Pine.LNX.4.44.0201301813310.5518-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.3.95.1020130113133.15383A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Zwane Mwaikambo wrote:

> On Wed, 30 Jan 2002, Richard B. Johnson wrote:
> 
> > 
> > When I ping two linux machines on a private link, I get 0.1 ms delay.
> > When I send large TCP/IP stream data between them, I get almost
> > 10 megabytes per second on a 100-base link. Wonderful.
> > 
> > However, if I send 64 bytes from one machine and send it back, simple
> > TCP/IP strean connection, it takes 1 millisecond to get it back? There
> > seems to be some artifical delay somewhere.  How do I turn this OFF?
> 
> I would say its all in the TCP connection initiation (socket(), create() 
> etc...)

But it's already connected.


         host:
         for (;;) {
            gettimeofday(...);
            write(s, buf, 64);
            read(s, buf, sizeof(buffer));
            gettimeofday(...);
         /* delay is 1.0 ms */
         }
         server is IPPORT_ECHO



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


