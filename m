Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266782AbUGLNJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266782AbUGLNJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUGLNJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:09:17 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:12303 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266782AbUGLNJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:09:15 -0400
Message-ID: <2a4f155d04071206091858afb2@mail.gmail.com>
Date: Mon, 12 Jul 2004 16:09:14 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Ingo Molnar <mingo@elte.hu>, Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <s5hllhpcxgv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20040709182638.GA11310@elte.hu>
	<1089407610.10745.5.camel@localhost>
	<20040710080234.GA25155@elte.hu>
	<20040710085044.GA14262@elte.hu>
	<2a4f155d040710035512f21d34@mail.gmail.com> <s5hllhpcxgv.wl@alsa2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont't have NPTL.

On Mon, 12 Jul 2004 12:48:48 +0200, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 10 Jul 2004 13:55:25 +0300,
> ismail dönmez wrote:
> >
> > Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM
> >
> > I did cp -rf big_folder new_folder . Then opened up a gui ftp client
> > and music in amarok started to skip like for 2-3 seconds.
> >
> > Btw Amarok uses Artsd ( KDE Sound Daemon ) which in turn set to use
> > Jack Alsa Backend.
> 
> Did you run JACK on linuxthreads (with LD_ASSUME_KERNEL=2.4.xx) ?
> 
> On NPTL with jackstart, JACK clients don't get set to SCHED_FIFO
> correctly.
> 
> 
> Takashi
> 


-- 
Time is what you make of it
