Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267625AbSLSMKU>; Thu, 19 Dec 2002 07:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbSLSMKU>; Thu, 19 Dec 2002 07:10:20 -0500
Received: from gate.perex.cz ([194.212.165.105]:1808 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267625AbSLSMKS>;
	Thu, 19 Dec 2002 07:10:18 -0500
Date: Thu, 19 Dec 2002 13:18:10 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Takashi Iwai <tiwai@suse.de>
cc: "Ruslan U. Zakirov" <cubic@miee.ru>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
In-Reply-To: <s5hof7ius93.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.33.0212191314460.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Takashi Iwai wrote:

> At Wed, 18 Dec 2002 22:51:27 +0300 (MSK),
> Ruslan U. Zakirov <cubic@miee.ru> wrote:
> > 
> > Hello, Jaroslav and All.
> > How about other changes in new 2.5 kernel, like new PnP layer (Adam Belay)
> > or changes with module & boot params (Rusty Russel)? There are now some
> > changes in 2.5.52 kernel in sound/isa/opl3sa2.c that make this driver not
> > compatible with other kernels. May be it's better split your tree in
> > several trees for each version of kernels?
> 
> if possible, we'll build up some wrapper for 2.4 on alsa-driver (not
> the codebase for 2.5) tree.  if not possible, yes, splitting to two
> trees would be reasonable for such big changes...
> 
> thanks for noticing this issue.  i'll check them now.

I just removed the complete callback redefinitions from the 2.5 tree, 
but we still have three small OLD_USB sections (mainly commenting 2.5 
code which 2.4 code requires to override). Hopefully, it's quite reasonable.
What do you think, Greg?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


