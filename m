Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUFQLwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUFQLwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 07:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUFQLwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 07:52:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266459AbUFQLwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 07:52:44 -0400
Date: Thu, 17 Jun 2004 07:52:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: andre@tomt.net, linux-kernel@vger.kernel.org
Subject: Re: Programtically tell diff between HT and real
In-Reply-To: <Pine.LNX.4.53.0406170721480.2683@chaos>
Message-ID: <Pine.LNX.4.53.0406170751050.494@chaos>
References: <200406170855.i5H8tk15012560@alkaid.it.uu.se>
 <Pine.LNX.4.53.0406170721480.2683@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Richard B. Johnson wrote:

> On Thu, 17 Jun 2004, Mikael Pettersson wrote:
>
> > On Wed, 16 Jun 2004 17:58:26 -0400 (EDT), Richard B. Johnson wrote:
> > >> > I would love to know how you turn in on! This is one of those
> > >> > "latest-and-greatest" Intel D865PERL mother-boards and I've
> > >> > even flashed the BIOS with the "latest-and-greatest".
> > >>
> > >> The usual way is to enable HT in BIOS, and use a SMP enabled kernel.
> > >>
> > >
> > >It's a SMP kernel. There is no 'HT enable' in the BIOS setup.
> > >In fact, there is very little that can be set and, it's even
> > >very hard to convince it that I want to boot from a SCSI and
> > >not from the first disk it finds. One has to remove the battery
> > >to discharge the CMOS so it won't ignore the 'Del' key
> > >on startup. It's a very bad BIOS or a very bad board, I
> > >don't know which.
> >
> > Or you forgot to enable ACPI in the kernel.
> > For some reason, the MP tables aren't capable of
> > describing HT siblings, so the BIOSen do that
> > via the ACPI tables instead.
> >
>
> I'll look, thanks.
>
>

I enabled ACPI, recompiled, etc. Rebooted, still just one CPU
with another hidden inside that can't get out!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


