Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266960AbRGMJ6R>; Fri, 13 Jul 2001 05:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266992AbRGMJ6G>; Fri, 13 Jul 2001 05:58:06 -0400
Received: from ns.viventus.no ([195.18.200.139]:39688 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S266960AbRGMJ5t>;
	Fri, 13 Jul 2001 05:57:49 -0400
Date: Fri, 13 Jul 2001 11:52:49 +0200 (CEST)
From: Rafael Martinez <rafael@viewpoint.no>
To: Shawn Veader <shawn.veader@zapmedia.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: disk full or not?  Disk space dissapear :-(
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com>
Message-ID: <Pine.LNX.4.30.0107131141020.623-100000@mowgli.viewpoint.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Shawn Veader wrote:

> Date: Wed, 11 Jul 2001 15:30:11 -0400
> From: Shawn Veader <shawn.veader@zapmedia.com>
> To: linux-kernel@vger.kernel.org
> Subject: disk full or not?  you decide...
>
> we are using reiserfs on a system running 2.4.3 (i think i put all
> of the relavant patches into the kernel before i built it then...)
> we have a partition that is used when encoding ripped songs and
> storing large files such as video and music. we noticed recently
> that the partition reported itself as being full. after a reboot
> the system reported having 6G freed. now again after a day of use
> the space has dissappered. df now returns:
> ----

I have had det samme problem with 2.4.1, 2.4.3, 2.4.4 but I do not use
reiserfs, just normal ext2.

It does not happen all the time but sometimes when I delete a file bigger
than 2GB, the space used by the file is not freed, This space dissapears
from the system and the only way to get it back is to reboot the machine.

No errors, no problems with the rest of the system, the space just
dissapear.

We use to work with files up to 7-9GB and the only thing I can notice when
this happens is that the time it takes to erase the file is very, very
short (under a second) when the space dissapear and it takes a few seconds
to erase a file of this size when everything works OK.

Any ideas?

Sincerely
Rafael Martinez.

