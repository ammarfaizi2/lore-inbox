Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSAUFty>; Mon, 21 Jan 2002 00:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289063AbSAUFsA>; Mon, 21 Jan 2002 00:48:00 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289066AbSAUFrA>; Mon, 21 Jan 2002 00:47:00 -0500
Date: Fri, 18 Jan 2002 11:26:49 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.40.0201180928500.934-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10201181123530.4260-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since we are limited to 4k pages or 8 sectors transfers in multimode
for now, please set hdparm -m8 /dev/hdX.

http://www.kernel.org/pub/linux/kernel/people/hedrick/acb-io-2.5.3/ata-253p1-2+axboe1+fixes.patch.bz2

This should be a valid patch and it includes some extras for Jens.

On Fri, 18 Jan 2002, Davide Libenzi wrote:

> On Fri, 18 Jan 2002, Anton Altaparmakov wrote:
> 
> > Since the new IDE core from Andre is now solid as reported by various
> > people on IRC, here is my local patch (stable for me) which you can apply
> > to play with the shiny new IDE core (IDE core fix is same as
> > ata-253p1-2.bz2 from Jens). (-:
> 
> I would like to say the same. I worked with the fixed kernel
> 2.5.3-pre1+ata-253p1-2 yesterday w/out problems. I rebootedt the machine
> before leaving the office yesterday night and this morning it had a full
> screen :
> 
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> 
> I have to say that something like :
> 
> All work and no play makes Jack a dull boy ...
> All work and no play makes Jack a dull boy ...
> All work and no play makes Jack a dull boy ...
> 
> would have scared me more, but still i think there's some tuning to play
> with ...
> 
> 
> 
> 
> - Davide
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

