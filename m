Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284038AbRLIUIC>; Sun, 9 Dec 2001 15:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRLIUHw>; Sun, 9 Dec 2001 15:07:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43018 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284010AbRLIUHj>; Sun, 9 Dec 2001 15:07:39 -0500
Date: Sun, 9 Dec 2001 16:51:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slight Return (was Re: [VM] 2.4.14/15-pre4 too "swap-happy"?)
In-Reply-To: <20011208071259.C24098@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.21.0112091650410.24337-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Dec 2001, Ken Brownfield wrote:

> Just a quick followup to this, which is still a near show-stopper issue
> for me.
> 
> This is easy to reproduce for me if I run updatedb locally, and then run
> updatedb on a remote machine that's scanning an NFS-mounted filesystem
> from the original local machine.  Instant kswapd saturation, especially
> on large filesystems.
> 
> Doing updatedb on NFS-mounted filesystems also seems to cause kswapd to
> peg on the NFS-client side as well.

Can you reproduce the problem without the over NFS updatedb? 

Thanks 

