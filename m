Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTEOPec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTEOPec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:34:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264089AbTEOPea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:34:30 -0400
Date: Thu, 15 May 2003 11:46:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Ricker <kaboom@gatech.edu>
cc: Jesse Pollard <jesse@cats-chateau.net>,
       Mike Touloumtzis <miket@bluemug.com>, Ahmed Masud <masud@googgun.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.55.0305150931140.6447@verdande.oobleck.net>
Message-ID: <Pine.LNX.4.53.0305151139220.188@chaos>
References: <20030514074403.GA18152@bluemug.com> <20030514205847.GA18514@bluemug.com>
 <Pine.LNX.4.53.0305141724220.12328@chaos> <03051508174100.25285@tabby>
 <Pine.LNX.4.55.0305150913471.6447@verdande.oobleck.net>
 <Pine.LNX.4.53.0305151121420.19950@chaos> <Pine.LNX.4.55.0305150931140.6447@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Chris Ricker wrote:

> On Thu, 15 May 2003, Richard B. Johnson wrote:
>
> > > You don't have to do that. Richard is mis-informed. Any of the following
> > > still work on Red Hat Linux 9:
> > >
> > > init=/bin/bash         # drops you straight to a bash shell
> > > init 1                 # runs runlevel 1 SysV init scripts and rc.sysinit
> > > init single            # runs rc.sysinit, but not runlevel 1
> > > init emergency         # runs a shell
> > >
> > > all without going to rescue media.
> > >
> >
> > Bullshit. Try it.
>
> I just did. It works.
>
> If it's not working for you, it's because *you* did something (like, say,
> password your boot loader). By default, it's still possible on Red Hat Linux
> 9 out of the box.
>
> later,
> chris
> -

Sill bullshit. I did nothing except to try to help a neighbor
who got locked out of her machine. I spent most of Saturday
and all of Sunday trying to break in. The LILO command prompt
readily took "parameters". However, any parameter passed on
the command-line resulted in a try-to-kill init error. Her
machine uses an Adaptec SCSI controller which needs to be
loaded via initrd to make the root file-system available.

I tried Red-Hat 8.0 here at work. It works as you described.
There is no problem with it and LILO and initrd. However
Red Hat 9/Professional does not allow break-in, at least on
the machine tested...and I have several pissed off witnesses.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

