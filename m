Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTEOQKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTEOQKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:10:53 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:28097 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264095AbTEOQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:10:52 -0400
Date: Thu, 15 May 2003 12:21:25 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Chris Ricker <kaboom@gatech.edu>, Jesse Pollard <jesse@cats-chateau.net>,
       Mike Touloumtzis <miket@bluemug.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.53.0305151139220.188@chaos>
Message-ID: <Pine.LNX.4.33.0305151208160.17650-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 May 2003, Richard B. Johnson wrote:

> On Thu, 15 May 2003, Chris Ricker wrote:
>
> > On Thu, 15 May 2003, Richard B. Johnson wrote:
> >
> > > > You don't have to do that. Richard is mis-informed. Any of the following
> > > > still work on Red Hat Linux 9:
> > > >
> > > > init=/bin/bash         # drops you straight to a bash shell
> > > > init 1                 # runs runlevel 1 SysV init scripts and rc.sysinit
> > > > init single            # runs rc.sysinit, but not runlevel 1
> > > > init emergency         # runs a shell
> > > >
> > > > all without going to rescue media.
> > > >
> > >
>
> Sill bullshit. I did nothing except to try to help a neighbor
> who got locked out of her machine. I spent most of Saturday
> and all of Sunday trying to break in. The LILO command prompt
> readily took "parameters". However, any parameter passed on
> the command-line resulted in a try-to-kill init error. Her
> machine uses an Adaptec SCSI controller which needs to be
> loaded via initrd to make the root file-system available.
>
> I tried Red-Hat 8.0 here at work. It works as you described.
> There is no problem with it and LILO and initrd. However
> Red Hat 9/Professional does not allow break-in, at least on
> the machine tested...and I have several pissed off witnesses.
>

This is an issue directly to be taken up with the manufacturer and is a
bit off topic here. RedHat 9 professional can conceivably disallow
parameter passing. The fact that a system does not, out of the box, allow
for break-ins is a good thing(tm) for most part...  manually editing
password files is a bad thing(tm), this is why command line tools such as
useradd are provided.

Any how, I hope you got it all fixed.

Cheers,

Ahmed.

