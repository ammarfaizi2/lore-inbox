Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130716AbRBAU7k>; Thu, 1 Feb 2001 15:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131008AbRBAU7b>; Thu, 1 Feb 2001 15:59:31 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:16915 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130716AbRBAU7P>; Thu, 1 Feb 2001 15:59:15 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.52732.55971.245131@wire.cadcamlab.org>
Date: Thu, 1 Feb 2001 14:58:36 -0600 (CST)
To: John Jasen <jjasen1@umbc.edu>
Cc: "Michael J. Dikkema" <mjd@moot.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <20010201114848.A4161@cadcamlab.org>
	<Pine.SGI.4.31L.02.0102011349410.71788-100000@irix2.gl.umbc.edu>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[John Jasen]
> Errrr .... upon careful reading of the devfs/devfsd documentation,
> you'll find that it says to put /sbin/devfsd /dev in amongst the
> first lines in rc.sysinit.

> In looking through rc.sysinit, / is not mounted rw until much later.

Who said anything about *re*-mounting '/'?  We are talking about having
trouble mounting '/' the *first* time, i.e. before rc.sysinit ever gets
a chance to run.

How did you expect to run /sbin/devfsd when /sbin doesn't exist yet?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
