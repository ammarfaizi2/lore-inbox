Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUACTPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbUACTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:15:49 -0500
Received: from [193.138.115.2] ([193.138.115.2]:36613 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263996AbUACTPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:15:45 -0500
Date: Sat, 3 Jan 2004 20:12:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: linux-kernel@vger.kernel.org, Omkhar Arasaratnam <omkhar@rogers.com>,
       Petri Koistinen <petri.koistinen@iki.fi>
Subject: Re: [patch against 2.6.1-rc1-mm1] replace check_region with reque
 st_region in isp16.c
In-Reply-To: <20040103172639.GQ1718@actcom.co.il>
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC073CCB6E@difpst1a.dif.dk>
References: <20040103172639.GQ1718@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jan 2004, Muli Ben-Yehuda wrote:

> On Sat, Jan 03, 2004 at 06:06:20PM +0100, Jesper Juhl wrote:
>
> > One thing that surprised me was that the isp16 driver does not seem to
> > ever call request_region, it only ever calls check_region which
> confuses
> > me a bit - wouldn't it need to (also with older kernels) always call
> > request_region ?
>
> I think so. It looks broken as it was, playing with the IO region
> without requesting it first. Is anyone actually using this driver?
>
> > I would appreciate it is someone could take a quick look at the patch
> and
> > verify that it does the correct thing.
>
> Looks correct to me.
>
Thank you for looking at it, but I don't think I'll be taking it any
further since (as Petri Koistinen pointed out) Omkhar Arasaratnam seems to
already have a patch for this.

Guess I should have searched the LKML archives more thoroughly before
digging into this.. Oh well, I'll just go look at some other bits..


/Jesper Juhl
