Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291310AbSBMCTe>; Tue, 12 Feb 2002 21:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291311AbSBMCTO>; Tue, 12 Feb 2002 21:19:14 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:41431 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S291310AbSBMCTE>; Tue, 12 Feb 2002 21:19:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, inglem@cisco.com (Mukund Ingle)
Subject: Re: Quick question on Software RAID support.
Date: Tue, 12 Feb 2002 21:19:54 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16aoUH-0003mY-00@the-village.bc.nu>
In-Reply-To: <E16aoUH-0003mY-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020213021903.PBFY16300.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 February 2002 08:45 pm, Alan Cox wrote:
> > 1) Does the Software RAID-5 support automatic detection
> >      of a drive failure? How?
>
> It sees the commands failing on the underlying controller. Set up a
> software raid 5 and just yank a drive out of a  bay if you want to test it
>
> > 2) Has Linux Software RAID-5 been used in the Enterprise environment
> >      to support redundancy by any real-world networking company
> >      or this is just a tool used by individuals to provide redundancy on
> >      their own PCs in the labs and at home?
>
> Dunno about that. I just hack code 8)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I've seen a 20-way Linux software raid used to capture uncompressed HTDV 
video in realtime, as part of an HTDV video editing system for which I 
believe the client was billed six figures.

That was SCSI.  (Well, dual qlogic fiber channel controllers that pretended 
to be scsi.)  I've also encountered a couple companies selling 14-drive 
enclosures (IDE, they rackmount in a 3U or 4U) that are turned into big 
software raid systems for data hosting.

And of course, you might want to talk to IBM and their global file system 
stuff, and their implementation of the logical volume management stuff last 
year (what was not the one that Linus eventually went with, I believe...)

Does this count?

(I kind of doubt IBM, HP, or Sun are insterested in tools for individual 
end-users...)

Rob
