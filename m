Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284570AbRLIWg5>; Sun, 9 Dec 2001 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284575AbRLIWgr>; Sun, 9 Dec 2001 17:36:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60434 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284570AbRLIWga>; Sun, 9 Dec 2001 17:36:30 -0500
Date: Sun, 9 Dec 2001 19:20:05 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Rene Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <3C13E52A.48C0843D@linux-m68k.org>
Message-ID: <Pine.LNX.4.21.0112091919060.24350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, Roman Zippel wrote:

> Hi,
> 
> Richard Gooch wrote:
> 
> > There are some broken boot scripts (modelled after the long obsolete
> > rc.devfs script)
> 
> Which is still included in the kernel tree and at least Mandrake is
> currently using it.
> There were no signs of deprecation, so people are legally using it.
> 
> > This is not actually a problem for leaf nodes, since the user-space
> > created device nodes will still work. It just results in a warning
> > message.
> 
> Wrong, these are not just warning messages, the driver API has changed.
> 
> > So, in this case, the device nodes that the user wants to use will
> > still be there (created by the boot script) and will work fine.
> 
> Except the dynamic update of device nodes won't happen anymore, so it
> affects also all leaf nodes in the directories (e.g. partition entries
> won't be created/removed anymore). Events won't be created for these
> nodes as well, so configurations depending on this are broken as well.

Richard, 

Are the above problems really introduced by the changes ? 


