Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSJVCuI>; Mon, 21 Oct 2002 22:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSJVCuI>; Mon, 21 Oct 2002 22:50:08 -0400
Received: from nameservices.net ([208.234.25.16]:49199 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262020AbSJVCuH>;
	Mon, 21 Oct 2002 22:50:07 -0400
Message-ID: <3DB4BF7F.BF4F32CB@opersys.com>
Date: Mon, 21 Oct 2002 23:01:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: landley@trommello.org, Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: Son of crunch time: the list v1.2.
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:
> > 3) Linux Trace Toolkit (LTT) (Karim Yaghmour)
> > Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html
> > Patch:
> > http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
> > User tools: http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz
> 
> I dunno if this needs to be in the kernel...

We've had this debate with a couple of folks before, most notably with
Ingo Molnar. Here was the essence of my reply to Ingo then:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103272155416405&w=2
Ingo went on to provide us with a to-do list which we've complied with
100%.

Basically, there are plent of day-to-day user needs which LTT fills
perfectly. We don't expect users to recompile their kernel in order
to use a symbolic debugger and I don't see why users should need to
recompile their kernel to:
- solve complex inter-process interactions
- obtain exact measures regarding kernel vs. app time
- understand the exact dynamic interaction between their app, the
kernel and all the other processes running on the system.
- etc.

Here was Linus' take:
> I suspect we'll want to have some form of event tracing eventually, but
> I'm personally pretty convinced that it needs to be a per-CPU thing, and 
> the core mechanism would need to be very lightweight.
From:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103271992115305&w=2

As I explained at that time to Linus, these are exactly the features we
are looking for in LTT. And since that posting, we've added precisely
those features (as I had promissed Linus, must I add), among many others
requested by folks on the LKML. If there's something we've missed, I'm
all ears.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
