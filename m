Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280262AbRKIW5p>; Fri, 9 Nov 2001 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280263AbRKIW5h>; Fri, 9 Nov 2001 17:57:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27658 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280262AbRKIW50>;
	Fri, 9 Nov 2001 17:57:26 -0500
Date: Fri, 9 Nov 2001 20:57:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Erik Andersen <andersen@codepoet.org>
Cc: Ben Israel <ben@genesis-one.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Disk Performance
In-Reply-To: <20011109155309.A14308@codepoet.org>
Message-ID: <Pine.LNX.4.33L.0111092056160.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Erik Andersen wrote:
> On Fri Nov 09, 2001 at 08:31:32PM -0200, Rik van Riel wrote:
> > On Fri, 9 Nov 2001, Ben Israel wrote:
> >
> > > Why does my 40 Megabyte per second IDE drive, transfer files at best
> > > at 1-2 Megabytes per second?

> > # hdparm -d1 /dev/hda
> >
> > (not enabled by default because it corrupts data with some
> > old chipsets and/or disks)
>
> But wouldn't it make more sense to enable DMA by default, except
> for a set of blacklisted chipsets, rather then disabling it for
> everybody just because some older chipsets are crap?

The kernel does this, but only if CONFIG_IDEDMA_AUTO
is enabled ...

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

