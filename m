Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPV2z>; Thu, 16 Nov 2000 16:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKPV2p>; Thu, 16 Nov 2000 16:28:45 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:62456 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129069AbQKPV2c>; Thu, 16 Nov 2000 16:28:32 -0500
Date: Thu, 16 Nov 2000 18:54:53 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Pavel Machek <pavel@suse.cz>
cc: Andreas Osterburg <alanos@first.gmd.de>, linux-kernel@vger.kernel.org
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <20001116003646.A2549@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0011161854070.13085-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Pavel Machek wrote:

> > > Because I set up a diskless Linux-workstation, I want to swap
> > > over NFS. For this purpose I found only patches for "older"
> > > Linux-versions (2.0, 2.1, 2.2?).
> > 
> > > Does anyone know wheter there are patches for 2.4 or does anyone
> > > know another solution for this problem?
> > 
> > 1. you can swap over NBD
> 
> Are you sure, Rik? So we no longer have low-memory deadlocks in nbd?
> Wow, there used to be plenty of them in past.
> 
> Do you promise it is possible to swap over NBD?

David Miller will have to promise he removed the allocation
bugs from tcp.c ;)  [which seem to be the low-memory deadlocks
you observed as well]

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
