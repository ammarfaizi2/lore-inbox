Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUCWVCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbUCWVCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:02:19 -0500
Received: from mail.rdslink.ro ([193.231.236.20]:57027 "EHLO mail.rdslink.ro")
	by vger.kernel.org with ESMTP id S262837AbUCWVBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:01:05 -0500
Date: Tue, 23 Mar 2004 23:05:55 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: Jaroslav Kysela <perex@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with alsa (oss emulation)
In-Reply-To: <Pine.LNX.4.58.0403231056240.2186@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.53.0403232302090.350@grinch.ro>
References: <Pine.LNX.4.53.0403222329290.453@grinch.ro>
 <Pine.LNX.4.58.0403231056240.2186@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Jaroslav Kysela wrote:

> On Mon, 22 Mar 2004 caszonyi@rdslink.ro wrote:
>
> > Hi
> >
> > when i run
> > mplayer -speed 3 movie.avi
> > mplayer segfaults and there is an oops in the logs
> >
> > The above command line plays the movie at a speed above normal. It happens
> > for any value of speed > 1.
> >
> > It's 100% reproductible. It oopses with any media file (an mp3 file for
> > example), and with kernel 2.6.4 and 2.6.5rc2.
> > Kernels 2.6.2 and 2.6.3 work fine.
>
> I cannot reproduce here - gcc 3.3.1 (SuSE), 2.6.4. It seems that you
> trigger the gcc bug. Try enable CONFIG_FRAME_POINTER in your kernel and
> let me know, if it helps.
>

Yes. If i enable CONFIG_FRAME_POINTER in my kernel works ok.
I'll upgrade my gcc.

Thanks for help

> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>

Calin

--
"A mouse is a device used to point at
the xterm you want to type in".
Kim Alm on a.s.r.
