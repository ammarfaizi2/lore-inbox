Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbRELXjo>; Sat, 12 May 2001 19:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbRELXje>; Sat, 12 May 2001 19:39:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11743 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261348AbRELXjX>;
	Sat, 12 May 2001 19:39:23 -0400
Date: Sat, 12 May 2001 19:39:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <Pine.A41.4.31.0105130130060.19270-100000@pandora.inf.elte.hu>
Message-ID: <Pine.GSO.4.21.0105121935570.11973-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 May 2001, BERECZ Szabolcs wrote:

> On Sat, 12 May 2001, Alexander Viro wrote:
> 
> > - Doctor, it hurts when I do it!
> > - Don't do it, then.
> >
> > Just what behaviour had you expected?
> maybe that I don't have to shutdown?
> I think it's a *bad* behaviour

Erm... Let me restate: what did you expect to achieve with that?
Swap on device means that all contents of that device is lost.
Mounting fs from device generally means that you don't want the
loss of contents. At least until you unmount the thing.

