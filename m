Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSA3Qr4>; Wed, 30 Jan 2002 11:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290018AbSA3Qqc>; Wed, 30 Jan 2002 11:46:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64644 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290072AbSA3Qpo>; Wed, 30 Jan 2002 11:45:44 -0500
Date: Wed, 30 Jan 2002 11:47:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <Pine.LNX.4.44.0201301831120.5518-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.3.95.1020130114353.15469A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Zwane Mwaikambo wrote:

> On Wed, 30 Jan 2002, Richard B. Johnson wrote:
> 
> > But it's already connected.
> > 
> > 
> >          host:
> >          for (;;) {
> >             gettimeofday(...);
> >             write(s, buf, 64);
> >             read(s, buf, sizeof(buffer));
> >             gettimeofday(...);
> >          /* delay is 1.0 ms */
> >          }
> >          server is IPPORT_ECHO
> 
> You didn't make that explicit in your previous email, and anyway what kind 
> of resolution can you expect from gettimeofday...
> 

The resolution is in microseconds. That's the specification. Not
all 'codes' are exercised of course, but the resolution is sufficient
to discern a 10 to 30 microsecond difference. I'm trying to measure
milliseconds, well within its capability. FYI, this is what `ping`
and `traceroute` use. It's fine.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


