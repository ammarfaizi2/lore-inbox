Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129536AbRBAQAf>; Thu, 1 Feb 2001 11:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbRBAQAZ>; Thu, 1 Feb 2001 11:00:25 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:39558 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S129536AbRBAQAI>;
	Thu, 1 Feb 2001 11:00:08 -0500
Date: Thu, 1 Feb 2001 11:00:05 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: "Michael J. Dikkema" <mjd@moot.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca>
Message-ID: <Pine.SGI.4.31L.02.0102011058520.71788-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Michael J. Dikkema wrote:

> I went from 2.4.0 to 2.4.1 and was surprised that either the root
> filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> thinking there might have been a change with regards to the devfs
> tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
>
> I can't even get a shell with init=/bin/bash..

Sounds like a lack of devfsd, which handles backwards compatibility for
/dev entries.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
