Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUCALff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUCALfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:35:34 -0500
Received: from hell.org.pl ([212.244.218.42]:29449 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261184AbUCALf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:35:28 -0500
Date: Mon, 1 Mar 2004 12:35:29 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Frank <mhf@linuxmail.org>, Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301113528.GA21778@hell.org.pl>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Frank <mhf@linuxmail.org>,
	Micha Feigin <michf@post.tau.ac.il>,
	Software suspend <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th> <20040229213302.GA23719@luna.mooo.com> <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1078139361.21578.65.camel@gaston>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Benjamin Herrenschmidt:
> > - that 2.4 style PM got depreciated and let die before the
> >    "new-driver-model" PM is workin
> Except that it never worked
> > - that perfectly good drivers were rewritten from scratch,
> >    but without functioning PM support
> Please, give names.

USB UHCI driver could be a fine example of a regression -- it could survive
suspend in 2.4 under certain conditions, this is no longer true for 2.6.

There's also a great deal of people, who can't resume when AGP is being 
used -- that is again a regression over 2.4.

The above are major showstoppers for most laptop users that already got
used to stable and reliable swsusp and hence prefer to stick with 2.4.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
