Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135184AbRDLNQF>; Thu, 12 Apr 2001 09:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135185AbRDLNPz>; Thu, 12 Apr 2001 09:15:55 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:44713 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S135184AbRDLNPm>; Thu, 12 Apr 2001 09:15:42 -0400
Date: Thu, 12 Apr 2001 09:28:44 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vuser.vu.union.edu" <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [PATCH] matroxfb and mga XF4 driver coexistence...
In-Reply-To: <3AD5A7C4.D740ED74@neuronet.pitt.edu>
Message-ID: <Pine.LNX.4.31.0104120922070.15715-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Rafael E. Herrera wrote:

> > But only users using matroxfb complains to me and/or to linux-kernel ;-)
> > You know, it worked last week, but it does not work anymore today. And
> > only thing I changed was kernel. So it must be in kernel...

I thought I had seen at least one other complaint on l-k about seeing the
problem in text mode.

> I think he's referrig to the matrox cards. I have mentioned this
> happening to me in this list. I've a G450, if I use anything other than
> 'normal', going in and out of X makes my text console go blank. I don't
> use the frame buffer, by the way.

Yes, sorry I didn't make this clear.  I have a Matrox G400.

> If the problem occurs whithout the frame buffer on, the problem seems to
> be on the X server.

Exactly.  That is what I'm saying.  I've seen the problem with the
returning to VESA text modes from XFree 4.0 anytime I use the hallib, with
2.2 and 2.4 kernels.  If I compile an X server without the hallib it's
fine (G450 users don't have that option, and I like my dual head).

If X changes the mode upon starting it should put it back when it is done.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

