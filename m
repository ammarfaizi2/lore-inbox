Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVBAOsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVBAOsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVBAOsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:48:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:16065 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262028AbVBAOsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:48:05 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Tue, 1 Feb 2005 15:48:03 +0100
User-Agent: KMail/1.7.1
References: <200501311015.20964.arjan@infradead.org> <200502011044.39259.busser@m-privacy.de> <20050201114659.GA30978@elte.hu>
In-Reply-To: <20050201114659.GA30978@elte.hu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502011548.03422.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 February 2005 12:46, you wrote:
> * Peter Busser <busser@m-privacy.de> wrote:
> > > ok the paxtest 0.9.5 I downloaded from a security site (not yours) had
> > > this gem in:
> > >
> > > +               do_mprotect((unsigned long)argv & ~4095U, 4096,
> > > PROT_READ|PROT_WRITE|PROT_EXEC);
> > >
> > > which is clearly there to sabotage any segmentation based approach (eg
> > > execshield and openwall etc); it cannot have any other possible use or
> > > meaning.
> > >
> > > the paxtest 0.9.6 that John Moser mailed to this list had this gem in
> > > it:
> > >
> > > +       /* Dummy nested function */
> > > +       void dummy(void) {}
> > >
> > > which is clearly there with the only possible function of sabotaging
> > > the automatic PT_GNU_STACK setting by the toolchain (which btw is not
> > > fedora specific but happens by all new enough (3.3 or later) gcc
> > > compilers on all distros) since that requires an executable stack.
>
> [...]
>
> > No, these things are also in the officially released sources. I put
> > them in myself in fact.
>
> *PLONK*

You still don't get it, do you?

Groetjes,
Peter.
