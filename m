Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRIDRiB>; Tue, 4 Sep 2001 13:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRhv>; Tue, 4 Sep 2001 13:37:51 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:10100 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S269815AbRIDRha>; Tue, 4 Sep 2001 13:37:30 -0400
Date: Tue, 4 Sep 2001 19:36:56 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@localhost.localdomain>
To: Thiago Vinhas de Moraes <thiago@vinhas.com.br>
cc: Thiago Vinhas de Moraes <tvlists@networx.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Sound Blaster Live - OSS or Not?
In-Reply-To: <200109041706.f84H6os25724@saturno.networx.com.br>
Message-ID: <Pine.LNX.4.33.0109041924200.2538-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Thiago Vinhas de Moraes wrote:

Apparently your strace is of the sh script that runs q3a, not of q3a
itself.

One thing I noticed is that you are running an ancient version of quake
(v1.11). Since there are people successfully running Q3 can you try to
update to the latest (v1.29h) and see if that fixes the problem?


> Em Ter, 04 de Set de 2001 09:09, rui.p.m.sousa@clix.pt escreveu:
> > On Mon, 3 Sep 2001, Thiago Vinhas de Moraes wrote:
> > > Hi!
> > >
> > > I have a Sound Blaster Live! PCI that works pretty fine for me.
> > >
> > > I tried to run loki's Quake 3 Arena for Linux, and after several tries, I
> > > started to read the README file,
> >
> > Some persons are reporting problems with Q3 (which mmap's /dev/dsp)
> > and the latest emu10k1 driver. Others (like me) don't see any problems.
> > Under investigation.
> >
> > What Q3 version are you using?
> > Can you send me a strace of the Q3 startup?
> >
> > > and it said that Sound Blaster Live does not
> > > work as OSS.
> >
> > The driver definetely follows the OSS specification. If a problem was
> > found at Loki then it would be nice to have a detailed bug report...
>
> The strace log is attached to this message.
> I really don't know how to make this work properly, since the only way I got
> Q3 to work with my SBLive was using the commercial OSS from opensound.com.
> The OSS/Free and the Alsa Project just give me the same output:

This indicates a problem with quake not the sound driver. Two totally
diferent drivers with the same problem...(when they are known to work
for other users)

Rui

> ...loading 'scripts/organics.shader'
> ...loading 'scripts/sfx.shader'
> ...loading 'scripts/shrine.shader'
> ...loading 'scripts/skin.shader'
> ...loading 'scripts/sky.shader'
> ...loading 'scripts/test.shader'
> ----- finished R_Init -----
>
> ------- sound initialization -------
> ------------------------------------
> Received signal 11, exiting...
>
> Regards,
> Thiago

