Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292687AbSBUSE5>; Thu, 21 Feb 2002 13:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292683AbSBUSEl>; Thu, 21 Feb 2002 13:04:41 -0500
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:63698 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S292687AbSBUSEU>; Thu, 21 Feb 2002 13:04:20 -0500
Date: Thu, 21 Feb 2002 13:04:18 -0500 (EST)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: <kmsmith@robotron.gpcc.itd.umich.edu>
To: <bwatson@kahuna.cag.cpqcorp.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
Message-ID: <Pine.SOL.4.33.0202211255240.9973-100000@robotron.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue Feb 12 2002, 17:45:00 EST, Brian Watson wrote:

> Marcelo-
>
> Attached is a patch that adds trylock routines for read/write
> semaphores. David Howells saw it last August and thought it was ready
> to be submitted then, but I became distracted and haven't taken the
> time to submit it until now. My motivation is that Christoph Hellwig
> says he needs it for JFS.

I just returned from vacation and saw this thread.  I also need trylock()
routines for read-write semaphores for NFS version 4, but you're way ahead
of me: I hadn't even started to implement them yet, and have been working
around the deficiency.  So I would really like to see some variant of this
patch go into the 2.5.x series eventually.  Anything I can do to help out?

Cheers,
 Kendrick Smith
 Center for Information Technology and Integration, University of Michigan

