Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUAISNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbUAISNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:13:21 -0500
Received: from [193.138.115.2] ([193.138.115.2]:41224 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263466AbUAISNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:13:20 -0500
Date: Fri, 9 Jan 2004 19:10:31 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: lkml@nitwit.de
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: The hardware reports a non fatal, correctable incident
 occured on CPU 0.
In-Reply-To: <200401091856.16120.lkml@nitwit.de>
Message-ID: <Pine.LNX.4.56.0401091903170.12889@jju_lnx.backbone.dif.dk>
References: <200401091748.10859.lkml@nitwit.de>
 <8A43C34093B3D5119F7D0004AC56F4BC0751591E@difpst1a.dif.dk>
 <200401091856.16120.lkml@nitwit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jan 2004 lkml@nitwit.de wrote:

> On Friday 09 January 2004 18:35, Jesper Juhl wrote:
> > It's nothing to do with the OS most likely. Some BIOS's modify the FSB
> > speed and other settings as a way to provide a sort of "fail safe" boot
> > mode if a problem was detected.
>
> So, in your opinion I really have hardware problems (which yet didn't notice
> and also for 3,5h did not recurr)?
>
All I'm saying is that I know for a fact that some BIOS's will do this
(set bus speed to 100) if they detect problems - I know mine does.

It's just one possibility. I don't actually /know/ what causes what you
experienced.
I guess it's possible that something the kernel did caused the BIOS to
think there was a problem even though there was not...
Or it could be something else entirely.
I don't know for sure. All I can do is suggest that maybe you should check
your motherboard manual for any hints on this behaviour and maybe try and
test your hardware just to be safe...

Other people probably have better advice for you.


-- Jesper Juhl

