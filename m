Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135423AbRAUFpO>; Sun, 21 Jan 2001 00:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135460AbRAUFpE>; Sun, 21 Jan 2001 00:45:04 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25348
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135423AbRAUFoq>; Sun, 21 Jan 2001 00:44:46 -0500
Date: Sat, 20 Jan 2001 21:44:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Device List Maintainer <device@lanana.org>
Subject: Re: Minors remaining in Major 10 ??
In-Reply-To: <3A6A7639.7F4A0A21@transmeta.com>
Message-ID: <Pine.LNX.4.10.10101202142270.657-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, H. Peter Anvin wrote:

> Andre Hedrick wrote:
> > 
> > Hi Peter,
> > 
> > Regardless if we rip out the entire rule of majors for dev_t, will there
> > be a service dummy driver to various block-devices?  There is a real need
> > for this if we are going to get full control of the hardware by indirect
> > access obtain the functionality that I see and need in the near future.
> > 
> 
> At this point, I'll allocate a device number when someone is ready to
> release a driver - no sooner.  There simply is not a whole lot of choice
> because of the extreme shortage of device numbers that's going to last us
> until dev_t gets expanded.

Cool Peter!

Will finish the code hack and clean it up in the next three days or so...  
It is only an idea to test and you can see it in action first.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
