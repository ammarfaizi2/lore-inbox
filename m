Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUCAL5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUCAL5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:57:45 -0500
Received: from hell.org.pl ([212.244.218.42]:12301 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261241AbUCAL5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:57:09 -0500
Date: Mon, 1 Mar 2004 12:57:08 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Frank <mhf@linuxmail.org>, Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301115708.GB2774@hell.org.pl>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Frank <mhf@linuxmail.org>,
	Micha Feigin <michf@post.tau.ac.il>,
	Software suspend <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th> <20040229213302.GA23719@luna.mooo.com> <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston> <20040301113528.GA21778@hell.org.pl> <1078140689.21577.78.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1078140689.21577.78.camel@gaston>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Benjamin Herrenschmidt:
> > USB UHCI driver could be a fine example of a regression -- it could survive
> > suspend in 2.4 under certain conditions, this is no longer true for 2.6.
> > 
> > There's also a great deal of people, who can't resume when AGP is being 
> > used -- that is again a regression over 2.4.
> > 
> > The above are major showstoppers for most laptop users that already got
> > used to stable and reliable swsusp and hence prefer to stick with 2.4.
> Oh... and what about looking into the problem instead and adding/fixing
> the necessary stuff ? It's not _that_ rocket science (and I have no
> UHCI hardware to do it myself, thanks).

Well, the AGP problem is black magic to me. Those hangs / reboots happen
during the copying of the original kernel back (when S4 is concerned) and
that's completely beyond me, sorry.

I did try to look into the USB problem back then, but again, I couldn't
find anything significantly different between 2.4 and 2.6, so I backed out.
Anyway, you're still right about that one should fix it instead of
complaining...
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
