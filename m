Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSLQK0E>; Tue, 17 Dec 2002 05:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSLQK0E>; Tue, 17 Dec 2002 05:26:04 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:36505 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S264872AbSLQK0D>; Tue, 17 Dec 2002 05:26:03 -0500
Subject: Re: Alcatel speedtouch USB driver and SMP.
From: Alex Bennee <alex@braddahead.com>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Greg KH <greg@kroah.com>, Colin Paul Adams <colin@colina.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9560000.1040119378@localhost.localdomain>
References: <m3n0n7hi52.fsf@colina.demon.co.uk>
	<20021215075913.GB2180@kroah.com> <m3hedfhd5l.fsf@colina.demon.co.uk>
	<20021216051300.GB12884@kroah.com>
	<3880000.1040039852@localhost.localdomain> 
	<9560000.1040119378@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 17 Dec 2002 10:30:38 +0000
Message-Id: <1040121039.1221.152.camel@cambridge.braddahead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 10:02, Andrew McGregor wrote:
> The 2.5 tree one works for me *with PPPoATM*, which I gather is kind of a 
> rare setup.
>
> Andrew

Not that rare, pppoa is quite common in Europe setups. FWIW there is now
a pppoe patch available for the user-mode driver (speedtouch.sf.net) so
if you have any problems with the kernel mode drivers you have a
fall-back position.

> 
> --On Tuesday, December 17, 2002 00:57:32 +1300 Andrew McGregor 
> <andrew@indranet.co.nz> wrote:
> 
> > There's a binary only one from Alcatel themselves, which only works on
> > one 2.2 kernel and one (old) 2.4 kernel, the other is on SourceForge, and
> > is also GPL.
> >
> > Andrew, who's just set up one himself on 2.4 and will try 2.5 when enough
> > else behaves.
> >
> > --On Sunday, December 15, 2002 21:13:00 -0800 Greg KH <greg@kroah.com>
> > wrote:
> >
> >> On Sun, Dec 15, 2002 at 08:58:14AM +0000, Colin Paul Adams wrote:
> >>> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> >>>
> >>>     Greg> On Sun, Dec 15, 2002 at 07:10:33AM +0000, Colin Paul Adams
> >>>     Greg> wrote:
> >>>     >> Can anyone tell me if the speedtouch driver is SMP safe yet?
> >>>
> >>>     Greg> Which driver?  I know of at least 3 different ones :(
> >>>
> >>> drivers/usb/misc/speedtouch.c
> >>
> >> Ah good, you're using one that the source is available for :)
> >> I think the developer has said it will work on SMP machines, but what
> >> problems are you having, and have you asked the author of the code?
> >>
> >>> Where are the others?
> >>
> >> I don't know, but I know they are out there...
> >>
> >> thanks,
> >>
> >> greg k-h
> >> -
> 
-- 
Alex Bennee
Senior Hacker, Braddahead Ltd
The above is probably my personal opinion and may not be that of my
employer

