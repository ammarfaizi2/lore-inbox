Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293388AbSB1XMq>; Thu, 28 Feb 2002 18:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310186AbSB1XIp>; Thu, 28 Feb 2002 18:08:45 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:8462 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310214AbSB1XFD>;
	Thu, 28 Feb 2002 18:05:03 -0500
Date: Thu, 28 Feb 2002 20:04:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Christoph Hellwig <hch@caldera.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <Pine.LNX.3.96.1020228174142.2006I-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33L.0202282002260.2801-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Bill Davidsen wrote:
> On Tue, 26 Feb 2002, Christoph Hellwig wrote:
>
> > They shouldn't,  But many old drivers do (and _had to_):
> >
> > 	current->policy = SCHED_YIELD;
> > 	schedule();
> >
> > which isn't possible with the new scheduler.
>
> Let's see, the choices are to (a) keep the old scheduler which has many
> performance issues, or (b) put in the new scheduler and let people who
> need the old drivers either fix them or stop upgrading.

or (c) have proponents of the inclusion of the O(1) scheduler
fix all drivers before having the O(1) scheduler considered
for inclusion.

Adding a yield() function to 2.4's scheduler and fixing all
the drivers to use it isn't that hard. Now all that's needed
are some O(1) fans willing to do the grunt work.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

