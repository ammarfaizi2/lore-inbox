Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSGJTQK>; Wed, 10 Jul 2002 15:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGJTQJ>; Wed, 10 Jul 2002 15:16:09 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:11539 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S315758AbSGJTQI>; Wed, 10 Jul 2002 15:16:08 -0400
Message-ID: <3D2C88D2.B5FF2DC2@opersys.com>
Date: Wed, 10 Jul 2002 15:19:46 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: Thunder from the hill <thunder@ngforever.de>, Adrian Bunk <bunk@fs.tum.de>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       bob <bob@watson.ibm.com>, Richard Moore <richardj_moore@uk.ibm.com>
Subject: Re: [STATUS 2.5]  July 10, 2002
References: <Pine.LNX.4.44.0207101027380.5067-100000@hawkeye.luckynet.adm> <3D2C66D9.AF14035A@opersys.com> <20020710172513.GB49811@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Levon wrote:
> On Wed, Jul 10, 2002 at 12:54:49PM -0400, Karim Yaghmour wrote:
> 
> > In light of the recent discussions, it would be really nice to get a
> > definitive statement about LTT's inclusion in 2.5.
> 
> It has been pointed out to you at least once that it would stand a much
> better chance if you were to follow the kernel coding style, for one ...

And if you had actually cared to follow that thread with Roman Zippel to
its logical conclusion, you would have noticed that patches including an
update to match the coding style have been made available:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102106555627527&w=2

> And things like :
> 
> +#ifndef CONFIG_SMP /* On an SMP machine NMIs are used to implement a watchdog and will hang
> +                      the machine if traced. */
> +        TRACE_TRAP_ENTRY(2, regs->eip);
> +#endif
> +
> 
> aren't very encouraging.

Care to comment on why? All what the above says is that this trace point
shouldn't be active on an SMP box. That's one of the very rare cases
(if not the only case) where such a build-condition is added. And if this
really is too much for the kernel crowd's stomach then it is easily remedied.

I would have thought you had something a little bit more substantial
to stand against LTT's inclusion.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
