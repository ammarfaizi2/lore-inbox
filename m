Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbRHBAag>; Wed, 1 Aug 2001 20:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbRHBAa0>; Wed, 1 Aug 2001 20:30:26 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:62349 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S268021AbRHBAaR>; Wed, 1 Aug 2001 20:30:17 -0400
Message-ID: <3B679A17.F6307158@ameritech.net>
Date: Wed, 01 Aug 2001 00:56:39 -0500
From: paulr <reichp@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: REPOST by request: String literal patch  (was Re: 2.4.7 -- GCC-3.0 
 -- "multiline string literals deprecated" -- PATCH)
In-Reply-To: <mailman.996555420.7957.linux-kernel2news@redhat.com> <200107310605.f6V65NZ26153@devserv.devel.redhat.com> <3B678655.BADEDCD7@ameritech.net> <20010801134046.A2539@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > Date: Tue, 31 Jul 2001 23:32:21 -0500
> > From: paulr <reichp@ameritech.net>
> > To: Pete Zaitcev <zaitcev@redhat.com>
> > CC: linux-kernel@vger.kernel.org

---------------------<etc>---------------------
> > --- linux/arch/i386/kernel/semaphore.c.orig   Sat Jul 28 13:57:29 2001
> > +++ linux/arch/i386/kernel/semaphore.c        Sat Jul 28 14:50:50 2001
> > @@ -181,56 +181,56 @@
> >  ".text\n"
> >  ".align 4\n"
> >  ".globl __down_failed\n"
> > -"__down_failed:\n\t"
> > -     "pushl %eax\n\t"
> > +"__down_failed:\n"
> > +"    pushl %eax\n"
> > +"    pushl %edx\n"
> 
> Why did you replace this? It was not a multi-line literal.
> It it triggered a warning, I'd suspect the gcc.
> 
> -- Pete

Pete,

There was no operational or gcc-3.0 compiler 
issue with the above stanza.

I altered this section only only to indent and 
align the text.  My choice was Purely Esthetic(TM).

It worked fine either way, 'specially on a GHz
althlon   ;-)

Regards,

Paul


-- 
*********************************************
Paul Reich              RF/Microwave Engineer

    Support the "Freedom To Innovate"...
                Just say "No".

*********************************************
