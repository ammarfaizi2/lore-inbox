Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSG1X2K>; Sun, 28 Jul 2002 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSG1X2J>; Sun, 28 Jul 2002 19:28:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20742 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317419AbSG1X2J>; Sun, 28 Jul 2002 19:28:09 -0400
Date: Sun, 28 Jul 2002 16:32:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: martin@dalecki.de, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
In-Reply-To: <20020728212523.A3460@suse.de>
Message-ID: <Pine.LNX.4.44.0207281628360.8208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Jens Axboe wrote:
>
> But the crap still got merged, sigh... Yet again an excellent point of
> why stuff like this should go through the maintainer. Apparently Linus
> blindly applies this stuff.

Ehh, since there is no proactive maintainer for SCSI, I don't have much
choice, do I?

SCSI has been maintainerless for the last few years. Right now three
people work on it to some degree (Doug Ledford, James Bottomley and you),
but I don't get timely patches, and neither does apparently anybody else.

Case in point: I was debugging some USB storage issues with Matthew Dharm
yesterday, and he sent me patches to the SCSI subsystem that he claims
were supposedly considered valid on the scsi mailing list back in May.

Guess what? I've not seen the patches from any of the three people I
consider closest to being maintainers.

So your "should go through the maintainer" complaint is obviously a bunch
of bull. Feel free to step up to the plate, but before you do, don't throw
rocks in glass houses.

				Linus

