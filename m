Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbREMOUc>; Sun, 13 May 2001 10:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbREMOUW>; Sun, 13 May 2001 10:20:22 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:21519 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S261406AbREMOUE>;
	Sun, 13 May 2001 10:20:04 -0400
Date: Sun, 13 May 2001 07:21:25 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Alexander Viro <viro@math.psu.edu>
cc: BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <Pine.GSO.4.21.0105121935570.11973-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10105130720280.16778-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2001, Alexander Viro wrote:

> 
> 
> On Sun, 13 May 2001, BERECZ Szabolcs wrote:
> 
> > On Sat, 12 May 2001, Alexander Viro wrote:
> > 
> > > - Doctor, it hurts when I do it!
> > > - Don't do it, then.
> > >
> > > Just what behaviour had you expected?
> > maybe that I don't have to shutdown?
> > I think it's a *bad* behaviour
> 
> Erm... Let me restate: what did you expect to achieve with that?
> Swap on device means that all contents of that device is lost.
> Mounting fs from device generally means that you don't want the
> loss of contents. At least until you unmount the thing.
> 

Really? Then why do 2.4.x kernels let you mkfs a mounted fs?

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

