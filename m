Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbREPAPQ>; Tue, 15 May 2001 20:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbREPAPH>; Tue, 15 May 2001 20:15:07 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:25350 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S261725AbREPAO6>; Tue, 15 May 2001 20:14:58 -0400
Date: Tue, 15 May 2001 17:14:54 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Is printing broke on sparc ?
In-Reply-To: <Pine.LNX.4.32.0104171707310.22166-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.32.0105151712060.10349-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Tim ,

On Tue, 17 Apr 2001, Mr. James W. Laferriere wrote:
> On Tue, 17 Apr 2001, Tim Waugh wrote:
> > On Mon, Apr 16, 2001 at 05:54:41PM -0700, Mr. James W. Laferriere wrote:
> > > # /etc/printcap
> > > # Please don't edit this file directly unless you know what you are doing!
> > > # Be warned that the control-panel printtool requires a very strict format!
> > > # Look at the printcap(5) man page for more info.
> > > # This file can be edited with the printtool in the control-panel.
> > > ##PRINTTOOL3## LOCAL POSTSCRIPT 300x300 letter {} PostScript Default {}
> > > lp:\
> > > 	:sd=/var/spool/lpd/lp:\
> > > 	:mx#0:\
> > > 	:sh:\
> > > 	:lp=/dev/lp0:\
> > > 	:if=/var/spool/lpd/lp/filter:
> > [...]
> > > /c#eodiecnyotai rhernili s to rpaemn
> > >                                     s eehpo o-.ROLPR0 roif{\=sl:x
> > >                                                                  	/p:ao/lr

> > Please try adjusting the 'udelay (1)' lines in
> > drivers/parport/ieee1284_ops.c:parport_ieee1284_write_compat to be
> > larger delays (for example, try replacing the 1s with 2s, or 5s, and
> > see if that makes things better).
> 	I am going to look and see if there might be a ioctl for that
> 	function .  Failing that I shall recompile the kernel with each
> 	of those values & test until successful or it seems futile .
	Tries both 2's & 5's , Both did the leaving things out .  Although
	in a differant pattern with each .  Am going to try 10's next just
	for grins .   Twyl ,  JimL

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

