Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131639AbRAPS7O>; Tue, 16 Jan 2001 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAPS7E>; Tue, 16 Jan 2001 13:59:04 -0500
Received: from nic.lth.se ([130.235.20.3]:11968 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S131639AbRAPS6r>;
	Tue, 16 Jan 2001 13:58:47 -0500
Date: Tue, 16 Jan 2001 19:58:37 +0100
From: Jakob Borg <jakob@borg.pp.se>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG with 2.4.1-pre7 reiserfs
Message-ID: <20010116195837.A707@borg.pp.se>
In-Reply-To: <20010116192041.A466@borg.pp.se> <9424br$j3h$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <9424br$j3h$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 16, 2001 at 10:36:43AM -0800
X-Operating-System: Linux narayan 2.4.1-pre7 i686 SMP 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 10:36:43AM -0800, Linus Torvalds wrote:
> >I seem to remember more possibly useful information scrolling by my screen,
> >but it seems to not have made it to the logs, and I will shut down and fsck
> >the filesystem now...
> 
> It really needs the stack-trace to debug this sanely (along with
> translations of what the hex numbers are - see the bugreporting
> documentation in the kernel source tree). 

Got that in the other mail subjected "More information ... ". In the
meantime it seems the filesystem is unhurt because of this, but reiserfsck
says

uread_super_block: bad block is found at a new superblock location
uread_super_block: bad block is found at an old superblock location

which seems bogus. This is reiserfsck from the same suite that mkreiserfs
came from ("reiserfsprogs 3.x") so they should be talking about the same
sort of filesystem.

Regards,

-- 
Jakob Borg            mailto:jakob@borg.pp.se       (personal)
UNIX/network admin    mailto:jakob@debian.org    (development)
systems programmer    mailto:jakob@morotsmedia.se       (work)
                      http://jakob.borg.pp.se/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
