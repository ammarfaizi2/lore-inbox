Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUCALjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCALje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:39:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:12224 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261220AbUCALjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:39:32 -0500
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Michael Frank <mhf@linuxmail.org>, Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040301113528.GA21778@hell.org.pl>
References: <1ulUA-33w-3@gated-at.bofh.it>
	 <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	 <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>
	 <20040229213302.GA23719@luna.mooo.com>
	 <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>
	 <20040301113528.GA21778@hell.org.pl>
Content-Type: text/plain
Message-Id: <1078140515.21578.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 22:28:36 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-01 at 22:35, Karol Kozimor wrote:
> Thus wrote Benjamin Herrenschmidt:
> > > - that 2.4 style PM got depreciated and let die before the
> > >    "new-driver-model" PM is workin
> > Except that it never worked
> > > - that perfectly good drivers were rewritten from scratch,
> > >    but without functioning PM support
> > Please, give names.
> 
> USB UHCI driver could be a fine example of a regression -- it could survive
> suspend in 2.4 under certain conditions, this is no longer true for 2.6.

Well, it may have survived by mere luck... the fact is that 2.4 never
had an infrastructure allowing anything remotely safe for
suspend/resume.

> There's also a great deal of people, who can't resume when AGP is being 
> used -- that is again a regression over 2.4.
>
> The above are major showstoppers for most laptop users that already got
> used to stable and reliable swsusp and hence prefer to stick with 2.4.

There haven't been a regression in the AGP drivers themselves afaik.

Ben.


