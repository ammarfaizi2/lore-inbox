Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSCKAqS>; Sun, 10 Mar 2002 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCKAqE>; Sun, 10 Mar 2002 19:46:04 -0500
Received: from konza.flinthills.com ([64.39.200.1]:7136 "EHLO
	konza.flinthills.com") by vger.kernel.org with ESMTP
	id <S293249AbSCKApr>; Sun, 10 Mar 2002 19:45:47 -0500
Message-ID: <009501c1c895$f9008e10$d3c02740@flinthills.com>
From: "Derek J Witt" <djw@flinthills.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203101801150.30628-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Suspend support for IDE
Date: Sun, 10 Mar 2002 18:44:58 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yeah, these are 18" cables. I previously had my caviar setup as a secondary
master and not cable-select as far I could remember.  I  was using the end
connector due to space constraints in the case and the cable-length
restraints. I did attempt to have both hard drives on separate controllers.
I was trying to setup my swaps in a raid-like fashion. Once  I moved my
drives around in the case, I moved the caviar back to primary slave using
the end connector. It was using the end connector on secondary master due
not being able to stretch the middle connector to the caviar.

I was having the cable twist some strange ways just to get the cable to fit
properly.    This hard drive came out of an old gateway. It was setup as a
slave in that box too.

I suppose risking screwing up the IDE cable just to get it to  reach or fit
properly in a mid-tower isn't worth losing data via CRC errors...

I now have this IDE setup:

Primary master: Quantum Fireball SE6.4A
Primary slave:  Western Digital WDC AC36400L
Secondary master: Acer ATAPI CD-ROM 40x N0AP
Secondary slave: Acer ATAPI CD-RW 2x6x CRW6206A.

I got the CD-ROM in the middle 5 1/4" bay, the CD-RW in the bottom 5 1/4"
bay, the 3 1/2" floppy in the top 3 1/2" bay, the Caviar in the middle 3
1/2" bay, and the Quantum in the 3rd 3 1/2" bay below the floppy.  I was
using an  IDE cable from the old AT case I had. I think it was a faulty
cable in my situation. I have since replaced the cable and the cd drives are
working just fine even with dma enabled. I'm using an ATA66 cable for the
hard drives.

-- Derek Witt.

----- Original Message -----
From: "Mark Hahn" <hahn@physics.mcmaster.ca>
To: "Derek J Witt" <djw@flinthills.com>
Sent: Sunday, March 10, 2002 5:02 PM
Subject: Re: Suspend support for IDE


> > Does the IDE blacklist include those drives that malfunction if they're
not
> > using the correct connector on the IDE ribbon cable?
>
> no.  there is no specificity for connector unless you're using
cable-select.
>
> > I found out a few weeks ago that my Caviar WD36400 is  that particular.
> > Upon putting that drive back on the middle connector on secondary, my
box
> > was then able to suspend and resume without the drive disconnecting on
me.
>
> are your cables <=18", with both *ends* plugged in?  the spec requires
that.
>
>

