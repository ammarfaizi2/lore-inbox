Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTA1REV>; Tue, 28 Jan 2003 12:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTA1REV>; Tue, 28 Jan 2003 12:04:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58633 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267414AbTA1REU>; Tue, 28 Jan 2003 12:04:20 -0500
Date: Tue, 28 Jan 2003 12:10:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [2.5] initrd/mkinitrd still not working 
In-Reply-To: <20030128012921.8F7DB2C56F@lists.samba.org>
Message-ID: <Pine.LNX.3.96.1030128120708.32466C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Rusty Russell wrote:

> In message <200301201457.PAA25276@harpo.it.uu.se> you write:
> > As to why the .o -> .ko name change was necessary, I have no idea.
> > Rusty?
> 
> It's getting furthur and furthur from a normal .o.  Kai actually did
> the patch (that, of course, is what the K stands for 8).

Yeah, I think I noted that .ko was a good idea, just to prevent confusion.
However, the original post I made was sort of a subtle hint, let me stop
beating around the bush: how about adding mkinitrd to the other module
stuff before 0.9.9 is really released, using the same .old technique used
for insmod et al? It would allow people doing testing of both 2.4 and 2.5
kernels to stop fighting build issues.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

