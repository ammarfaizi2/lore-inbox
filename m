Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVBALrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVBALrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVBALrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:47:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:31125 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261998AbVBALrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:47:12 -0500
Date: Tue, 1 Feb 2005 12:46:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Busser <busser@m-privacy.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050201114659.GA30978@elte.hu>
References: <200501311015.20964.arjan@infradead.org> <200501311357.59630.busser@m-privacy.de> <1107189699.4221.124.camel@laptopd505.fenrus.org> <200502011044.39259.busser@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502011044.39259.busser@m-privacy.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Busser <busser@m-privacy.de> wrote:

> > ok the paxtest 0.9.5 I downloaded from a security site (not yours) had
> > this gem in:

> > +               do_mprotect((unsigned long)argv & ~4095U, 4096, PROT_READ|PROT_WRITE|PROT_EXEC);

> > which is clearly there to sabotage any segmentation based approach (eg
> > execshield and openwall etc); it cannot have any other possible use or
> > meaning.

> > the paxtest 0.9.6 that John Moser mailed to this list had this gem in
> > it:

> > +       /* Dummy nested function */
> > +       void dummy(void) {}

> > which is clearly there with the only possible function of sabotaging the
> > automatic PT_GNU_STACK setting by the toolchain (which btw is not fedora
> > specific but happens by all new enough (3.3 or later) gcc compilers on
> > all distros) since that requires an executable stack.
[...]

> No, these things are also in the officially released sources. I put
> them in myself in fact.

*PLONK*

	Ingo
