Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTKYUEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKYUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:04:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263102AbTKYUEU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:04:20 -0500
Date: Tue, 25 Nov 2003 15:07:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nick <nick@snowman.net>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       =?US-ASCII?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copy protection of the floppies
In-Reply-To: <Pine.LNX.4.21.0311251336250.24128-100000@ns.snowman.net>
Message-ID: <Pine.LNX.4.53.0311251501140.6546@chaos>
References: <Pine.LNX.4.21.0311251336250.24128-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Nick wrote:

> Hardware dongles.  You need to be a bit creative but it can be done.  Say
> on save of the file output it to the hardware dongle with encrypts it with
> your private key, then on load of the file it gets decrypted with the
> public key, which is available, or some similar scheme.
> 	Nick
>

Dongles all use the same scheme! This means that if you've made
one program that uses a dongle, you can certainly emulate it!


> On Tue, 25 Nov 2003, Ricky Beam wrote:
>
> > On Tue, 25 Nov 2003, [iso-8859-1] Måns Rullgård wrote:
> > >> About 15 years ago, there were many gaming softwares which were procected,
> > (it was more than 15 years ago.)
> > >> for example, by checking "gap" between sectors.
> > >
> > >Can't that be done with a regular floppy drive and some special
> > >software?
> >
> > Please heed the lessons already learned in the software industry...
> > Copy protection doesn't work.  It works about as well as locks on doors
> > as it'll keep the honest people honest, and offer a small obstacle to
> > the dishonest.
> >

It'll keep honest people pissed and others entertained. In the
DOS days, there were holes burned into the floppies in certain
sectors. This kept diskcopy and other DOS stuff from copying
the floppies.  I just made a TSR that emulated the burnt holes
for the application and a copy routine that didn't care about
bad sectors (it ignored them).

The result was that you didn't need a "key" disk in drive A:
anymore. To the user, you just executed the program.

> > can do. (And given this thread, I can probablly do a few things you
> > currently cannot.)  Ultimately, any copy protection comes down to
> > the software on the floppy.  If the machine can read it to execute it,
> > the hacker can read it to remove the checks.  No ammount of hand-waving
> > will change that. (That, btw, is why the DMCA, et. al., exist.)
> >
> > --Ricky
> >

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


