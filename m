Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271636AbRHUKcV>; Tue, 21 Aug 2001 06:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271637AbRHUKcL>; Tue, 21 Aug 2001 06:32:11 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:1318 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S271636AbRHUKbu>; Tue, 21 Aug 2001 06:31:50 -0400
Date: Tue, 21 Aug 2001 11:29:44 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sync hanging
In-Reply-To: <3B8223E2.48F7A586@namesys.com>
Message-ID: <Pine.LNX.4.21.0108211122550.11035-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hans,

On Tue, 21 Aug 2001, Hans Reiser wrote:
> Corin Hartland-Swann wrote:
> > I'm using kernel 2.4.8-ac2 on a Dual PIII-1000 with 4096M RAM, and a
> > reiserfs filesystem on a RAID-1 mirror of two 76GB UDMA disks, and I'm
> > experiencing a strange problem after the machine has been running for a
> > while.
> > 
> > Every now and again, running sync(1) (i.e. the program) seems to hang and
> > end up in state D (uninterruptible sleep). There is no way to kill it
> > (even with SIGKILL but I assume that this is typical for state D
> > processes.
> > 
> > Does anyone have any idea what may be causing this? I have searched the
> > archives and couldn't find anything similar.
>
> turn off highmem, known bug, I don't know if it is solved yet.

Is 2G RAM OK (by manually changing __PAGE_OFFSET ?)

Is this directly related to reiserfs (i.e. will it go away if I go back to
using ext2 or switch to xfs?)

How serious is the problem? Can I get away with using it as is (with
highmem) on a production server or will that cause serious repercussions?

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/

