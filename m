Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSHYM7Z>; Sun, 25 Aug 2002 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSHYM7Z>; Sun, 25 Aug 2002 08:59:25 -0400
Received: from pD9E236A6.dip.t-dialin.net ([217.226.54.166]:51369 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316898AbSHYM7Y>; Sun, 25 Aug 2002 08:59:24 -0400
Date: Sun, 25 Aug 2002 07:03:34 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Toon van der Pas <toon@vanvergehaald.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
In-Reply-To: <20020825145020.A15128@vdpas.hobby.nl>
Message-ID: <Pine.LNX.4.44.0208250659530.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Aug 2002, Toon van der Pas wrote:
> > If you think it's a _deadly_bad_idea_to_do_ please tell me. It is,
> > after all, just an RFC, means I request you to comment on this.
> > I could even ask for kernel protection for the mice.
> 
> A serious question about your proposal then:
> The .config file doesn't excusively contain information regarding
> what hardware to support.  It also carries a lot of information about
> the functionality and the optimzations the user wishes to incorporate
> in his kernel.  How would localconfig deal with that?

Well, the idea is to
 - scan the kernel messages for things that got loaded
 - figure the hardware configuration
 - figure out guessable optimizations
 - use the default values for the rest

I don't want to decide between "y" and "n". That would go wrong. The only 
thing is that there *should* be a decision on whether the support is vital 
for boot or not, if not we compile as module.

This statement is not valid for debug options, though...

> BTW: Considering that you are not out of your mind (most of the
> time), I admire your courage in bringing up this subject.  ;-)

I wonder whether that's a good thing...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

