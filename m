Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJYT52>; Thu, 25 Oct 2001 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276150AbRJYT5S>; Thu, 25 Oct 2001 15:57:18 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:8069 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S276132AbRJYT5J>;
	Thu, 25 Oct 2001 15:57:09 -0400
Date: Thu, 25 Oct 2001 21:57:44 +0200
From: Ookhoi <ookhoi@ookhoi.xs4all.nl>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 cannot find root device on raid
Message-ID: <20011025215743.B24475@humilis>
Reply-To: ookhoi@ookhoi.xs4all.nl
In-Reply-To: <15319.38517.663820.504760@notabene.cse.unsw.edu.au> <htYB7.5102$d%.933992639@newssvr17.news.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <htYB7.5102$d%.933992639@newssvr17.news.prodigy.com>
User-Agent: Mutt/1.3.19i
X-Uptime: 10:37:19 up 9 days, 16:44, 10 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <15319.38517.663820.504760@notabene.cse.unsw.edu.au>,
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> | On Tuesday October 23, davidsen@prodigy.com wrote:
> | > 
> | > The line you provide doesn't look anything like the two forms in the
> | > md.txt you mention. Or rather it looks like a blending, but neither of
> | > them is md0= in form. I have to look at the code to see which is
> | > correct, possibly yours, since the 
> | >   append = "md=0,/dev/sda1,/dev/sdb1"
> | > line doesn't seem to work :-(
> | 
> | Odd ... I use lines just like that. e.g.:
> |    append="md=0,/dev/hda1,/dev/hde1,/dev/hdg1"
> | 
> | and it works just fine.  What do you get in the way of error messages?
> 
> None - the system simply exits the BIOS, reads the first drive once and
> cold boots. The drive is okay, I can read both copies of the mirror end
> to end without error after booting from floppy. Lilo claims it writes to
> the md0 device, but boot fails.

I always let lilo write to the first and the second disk itself, and I
do not use any kernel parameters for sw raid. Is writing to the disks
instead of writing to /dev/md0 the wrong way? It works for me.

	Ookhoi
