Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQJaW5w>; Tue, 31 Oct 2000 17:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbQJaW5m>; Tue, 31 Oct 2000 17:57:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:28939 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129069AbQJaW5f>; Tue, 31 Oct 2000 17:57:35 -0500
Message-ID: <39FF4D7A.EF00E94A@timpanogas.org>
Date: Tue, 31 Oct 2000 15:53:46 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001031144907.B23516@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Larry McVoy wrote:
> 
> On Tue, Oct 31, 2000 at 03:38:00PM -0700, Jeff V. Merkey wrote:
> > Larry McVoy wrote:
> > > On Tue, Oct 31, 2000 at 03:15:37PM -0700, Jeff V. Merkey wrote:
> > > > The quality of the networking code in Linux is quite excellent.  There's
> > > > some scaling problems relative to NetWare.  We are firmly committed to
> > > > getting something out with a Linux code base and NetWare metrics.  Love
> > > > to have your help.
> > >
> > > Jeff, I'm a little concerned with some of your statements.  Netware may
> > > be the greatest thing since sliced bread, but it isn't a full operating
> > > system, so comparing it to Linux is sort of meaningless.
> >
> > It's makes more money in a week than Linux has ever made.
> 
> And the relevance of that to this conversation is exactly what?
> 
> > A context switch in anoperating system context in it's simplest for is
> >
> > mov    x, esp
> > mov    esp, y
> >
> > > and you can support all that and get user to user context switches in a
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Apology accepted.
> 
> No apology was extended.  

hipocrite.

You're spouting nonsense.  User to user means
> process A in VM 1 switching to process B in VM 2.  I'm sorry, Mr Merkey,
> but a
> 
>         mov    x, esp
>         mov    esp, y
> 
> doesn't begin to approach a user to user context switch.  Please go learn
> what a user to user context switch is.  Then come back when you can do
> one of those in a few cycles.

You have angry fingers (one of my problems).   You don't need a user
context switch for kernel paths in a NOS kernel.  In NetWare, user
context switches are done in gates in the GDT with TSS descriptors, not
in kernel fast paths with LAN I/O, which isn't what I was talking about. 

Jeff

> --
> ---
> Larry McVoy              lm at bitmover.com           http://www.bitmover.com/lm
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
