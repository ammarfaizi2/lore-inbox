Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUCALvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUCALvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:51:41 -0500
Received: from hell.org.pl ([212.244.218.42]:21519 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261239AbUCALvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:51:37 -0500
Date: Mon, 1 Mar 2004 12:51:35 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Frank <mhf@linuxmail.org>, Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301115135.GA2774@hell.org.pl>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Frank <mhf@linuxmail.org>,
	Micha Feigin <michf@post.tau.ac.il>,
	Software suspend <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th> <20040229213302.GA23719@luna.mooo.com> <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston> <20040301113528.GA21778@hell.org.pl> <1078140515.21578.76.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1078140515.21578.76.camel@gaston>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Benjamin Herrenschmidt:
> > USB UHCI driver could be a fine example of a regression -- it could survive
> > suspend in 2.4 under certain conditions, this is no longer true for 2.6.
> Well, it may have survived by mere luck... the fact is that 2.4 never

That's very likely. Anyway, pure luck is still better than no luck
whatsoever...

> had an infrastructure allowing anything remotely safe for
> suspend/resume.

Right, but the point is that while 2.6 has such an infrastructure, its
introduction actually completely broke UHCI suspend / resume.

> > There's also a great deal of people, who can't resume when AGP is being 
> > used -- that is again a regression over 2.4.
> There haven't been a regression in the AGP drivers themselves afaik.

Which, again, leads us to conclusion that it was the driver model change
that broke that.

I'm not trying to criticize the driver model itself (I'm sure others have
already done enough), but merely to emphasize that 2.6 is not yet ready for
laptop users.

Enough of that, this is becoming off-topic. :)
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
