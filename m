Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKORQN>; Wed, 15 Nov 2000 12:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbQKORQD>; Wed, 15 Nov 2000 12:16:03 -0500
Received: from modemcable248.137-200-24.mtl.mc.videotron.ca ([24.200.137.248]:12530
	"EHLO xanadu.gn.com") by vger.kernel.org with ESMTP
	id <S129187AbQKORP4>; Wed, 15 Nov 2000 12:15:56 -0500
Date: Wed, 15 Nov 2000 11:58:17 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andreas Osterburg <alanos@first.gmd.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <Pine.LNX.4.21.0011151421580.5584-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0011151156300.22936-100000@xanadu.gn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2000, Rik van Riel wrote:

> On Wed, 15 Nov 2000, Andreas Osterburg wrote:
>
> > Because I set up a diskless Linux-workstation, I want to swap
> > over NFS. For this purpose I found only patches for "older"
> > Linux-versions (2.0, 2.1, 2.2?).
>
> > Does anyone know wheter there are patches for 2.4 or does anyone
> > know another solution for this problem?
>
> 1. you can swap over NBD
> 2. if you point me to the swap-over-nfs patches you
>    have found, I can try to make them work on 2.4 ;)

Swap on the loop block device attached to a file over NFS seemed to work
too.


Nicolas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
