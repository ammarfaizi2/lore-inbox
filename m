Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTABRYK>; Thu, 2 Jan 2003 12:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTABRYK>; Thu, 2 Jan 2003 12:24:10 -0500
Received: from gate.perex.cz ([194.212.165.105]:32274 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265508AbTABRYJ>;
	Thu, 2 Jan 2003 12:24:09 -0500
Date: Thu, 2 Jan 2003 18:31:08 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
In-Reply-To: <20030102171803.GQ6114@fs.tum.de>
Message-ID: <Pine.LNX.4.33.0301021827160.649-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Adrian Bunk wrote:

> On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:
> 
> >...
> > Summary of changes from v2.5.53 to v2.5.54
> > ============================================
> >...
> > Jaroslav Kysela <perex@suse.cz>:
> >   o PnP update
> >...
> 
> FYI:
> 
> This change broke the compilation of drivers/ide/ide-pnp.c:

Yes, this code was not functional (although compilable). I've noted this 
situation in my patch comment. We have to upgrade all old ISA PnP code to 
the new PnP layer. It's better to fail with an error than silently ignore 
this situation (this will force more developers to update their parts).

I'll update our ALSA code ASAP.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


