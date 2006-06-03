Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWFCTMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWFCTMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 15:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWFCTMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 15:12:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43650 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751787AbWFCTMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 15:12:53 -0400
Message-Id: <200606031828.k53ISSgr012167@laptop11.inf.utfsm.cl>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
cc: linux-kernel@vger.kernel.org, "Kalin KOZHUHAROV" <kalin@thinrope.net>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
Subject: Re: Linux kernel development 
In-Reply-To: Message from "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> 
   of "Sat, 03 Jun 2006 15:36:22 +0200." <4d8e3fd30606030636m44e3ce28k9d0fb6938947d4b2@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sat, 03 Jun 2006 14:28:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:43:30 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 15:12:30 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 11/15/05, Greg KH <greg@kroah.com> wrote:
> [...]
> > >       http://linux.tar.bz/articles/2.6-development_process
> >
> > Ah, a very nice summary.
> >
> > Paolo, can I use this document as a base for this section in the HOWTO
> > file (with proper attribution of course.)
> 
> That article is now living in a git tree, it now contains only spell
> checks but I plan to work more on it in the next few days.

I'd break it up into logical pieces (i.e., chapters...)

The lines are way too long for easy reading.

There are several other tools to check kernel quality: sparse, the
lockcheck, ... And don't forget about the various debugging config options

There are required tools for serious kernel development, i.e. git and its
entournage. Link to them.

You mention that patches cook in -mm for a while, but you don't tell what
that is beforehand. In general, a high-level overview of the current
git-based development would be useful, and the various important git kernel
trees and the patch flow among them.

Don't be shy in mentioning the stuff under Documentation in your nearest
kernel source!

Perhaps do an asccidoc format, to be able to create HTML?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
