Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264722AbSJUD5b>; Sun, 20 Oct 2002 23:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSJUD5b>; Sun, 20 Oct 2002 23:57:31 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:56528 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264722AbSJUD5a> convert rfc822-to-8bit; Sun, 20 Oct 2002 23:57:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Bill Davidsen <davidsen@tmr.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
Date: Sun, 20 Oct 2002 18:02:54 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
References: <Pine.LNX.3.96.1021019151759.29078I-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021019151759.29078I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201802.54991.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 October 2002 14:23, Bill Davidsen wrote:
> On 19 Oct 2002, Eric W. Biederman wrote:
> > The kexec code has gone through a fairly decent review, and all known
> > bugs are resolved.  There are still BIOS's that don't work after you have
> > run a kernel but that is an entirely different problem.
> >
> > My real question: With Linus off on vacation my real question is who
> > should I send this to?
>
> I believe Linus explicitly said he wasn't going to tell anyone, which
> means we're back to the days of "through it on the list over and over
> until someone admits to seeing it." Or send it to everyone who might be
> willing to push it to Linus when he gets back.
>
> By not accepting stuff at this point I would guess that the defacto freeze
> is here. Hope I'm wrong, there is some good stuff which would be ready by
> Oct 31.

Linus implied there would be one more last minute surge of merges.  (Why else 
have people patch hoovering for anything other than bugs in the meantime?)

Probably the best thing to do is assemble a list of candidates, well-tested 
patches that have been up on the list and with as many endorsements from 
testers going "AOL!" as possible.  The last go-through when lkinus gets back 
is probably going to be simple thumbs-up thumbs down on each entry in the 
pending feature list, and then into the 3.0-pre series...

The current "pending feature list" would probably be here:

http://kernelnewbies.org/status/

Specifically:

o in -ac PCMCIA Zoom video support (Alan Cox) 
o in -ac Device mapper for Logical Volume Manager (LVM2)  (LVM2 team) 
o in -mm VM large page support  (Many people) 
o in -mm  Page table sharing  (Daniel Phillips, Dave McCracken) 

o Ready  Build option for Linux Trace Toolkit (LTT) (Karim Yaghmour) 
o Ready Dynamic Probes (dprobes team) 
o Ready Zerocopy NFS (Hirokazu Takahashi) 
o Ready High resolution timers (George Anzinger, etc.) 
o Ready EVMS (Enterprise Volume Management System) (EVMS team) 
o Ready Linux Kernel Crash Dumps (Matt Robinson, LKCD team) 
o Ready Rewrite of the console layer (James Simmons) 

If you're not on this list, contact Guillaume, or start your own list of 
"final merge candidates"...

Rob
