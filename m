Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292486AbSBPSe1>; Sat, 16 Feb 2002 13:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292487AbSBPSeR>; Sat, 16 Feb 2002 13:34:17 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47630
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292486AbSBPSd7>; Sat, 16 Feb 2002 13:33:59 -0500
Date: Sat, 16 Feb 2002 10:22:43 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Martin Dalecki <md@evision-ventures.com>
cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com
Subject: Re: IDE cleanup for 2.5.4-pre3
In-Reply-To: <3C6E2886.8070600@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10202161016380.10501-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

I asked you off line to slow down so I can fix a few issues.
I have acknowledged you ideas are good but are woefully untimely.
Obviously you have some agenada with a StartUp company because you work
for a Germnay Venture Capital firm.

Maybe it would be more useful if you bothered to feed the code via the
correct paths.  Since I am going to reject it until I can review it, and
have made very clear there are some core problems to address.  You can
make all kinds of fancy rewrites all day long but until the bottom
transport is finished it will still break.

Regards,

On Sat, 16 Feb 2002, Martin Dalecki wrote:

> Pavel Machek wrote:
> 
> >Hi!
> >
> >>It seems bigger as it is at first glance, however if you start to read 
> >>it at ide.h, the rest should
> >>be, well,  obivous...
> >>
> >
> >Ouch, its *big*. You should probably start pushing it to Jens ASAP,
> >because if you'll clean up it a bit more, you'll end with really big
> >patch which rewrites whole drivers/ide... [Not that it would be a bad
> >thing.]
> >
> 
> Well the atomic part of the patch is rather small if you look at it. But 
> in hell unfortunately there is
> no way around to make the consequences smaller. I would be much happier 
> if it could be
> done otherway around... but I see no way if one want's to preserve the 
> drivers in a functional state.
> 
> >My favourite cleanup would be 
> >
> >struct ide_drive_s {} ide_drive_t;
> >
> >=>
> >
> >struct ide_drive {};
> >
> >and replacing all ide_drive_t with struct ide_drive...
> >
> 
> That will happen.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

