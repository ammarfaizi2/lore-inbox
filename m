Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267827AbTAHRuc>; Wed, 8 Jan 2003 12:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267831AbTAHRuc>; Wed, 8 Jan 2003 12:50:32 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:57790 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267827AbTAHRub>; Wed, 8 Jan 2003 12:50:31 -0500
Date: Wed, 8 Jan 2003 12:59:07 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB CF reader reboots PC
Message-ID: <20030108175907.GB1189@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030108165130.GA1181@Master.Wizards> <20030108173356.GA1189@Master.Wizards> <3E1C64CE.8050709@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1C64CE.8050709@inet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 11:50:06AM -0600, Eli Carter wrote:
> Murray J. Root wrote:
> >Ooops - kernel 2.5.5[234]
> >
> >On Wed, Jan 08, 2003 at 11:51:30AM -0500, Murray J. Root wrote:
> >
> >>ASUS P4S533 (SiS645DX chipset)
> >>P4 2GHz
> >>1G PC2700 RAM
> >>SanDisk SDDR-77 ImageMate Dual Card Reader (using only CF cards)
> >>
> >>----------------------------
> >>devfs compiled in to kernel, devfs=nomount in lilo.conf
> >> 
> >>Insert CF card. mount it. cd to it, do reads and/or writes
> >>umount card. remove card.
> >>insert a different card (does not happen if the same card is used)
> >>mount it. system reboots. logs are corrupted
> >>
> >>Doesn't happen every time for read - sometimes I can read 2 or 3 cards 
> >>first
> >>Happens every time for write - if I write to a card then changing cards
> >>causes a reboot
> >>
> [snip]
> 
> Somewhat similar vein, but a different set of symptoms, I've seen a 
> RedHat box not see that the CF card changed...
> (USB SanDisk CF & SD reader, also using only CF cards.)
> 
> insert 128MB CF card.
> everything is ok.
> remove 128MB CF card, still see 128MB partition
> insert 256MB CF card.
> see 128MB partition.
> (based on /proc/partitions)
> 
> I've not followed this up to figure out why yet.
> You might check that situation to see if yours is related at all.

Using Mandrake Cooker and nope - it sees the change
That's actually part of the symptoms - if I put the
same card back in, no problem. It's only if I use a
different card that it reboots.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

