Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312374AbSCYJXK>; Mon, 25 Mar 2002 04:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312375AbSCYJXA>; Mon, 25 Mar 2002 04:23:00 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:57805 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312374AbSCYJWp>;
	Mon, 25 Mar 2002 04:22:45 -0500
Date: Mon, 25 Mar 2002 10:22:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-kernel <linux-kernel@vger.kernel.org>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.18: many IDE errors
Message-ID: <20020325102223.A13083@ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0203242314350.31118-100000@mustard.heime.net> <3C9E5226.FD8FAB70@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 09:24:38AM +1100, Eyal Lebedinsky wrote:
> Roy Sigurd Karlsbakk wrote:
> > 
> > > The PCI IDE cards I use are ATA-100, so this is the max speed available
> > > to be. The four large disks can do ATA-133.
> > >
> > > The 48bit addressing (to allow >137GB) seems to be unrelated, and it
> > > works with these cards. But I needed to apply:
> > >       http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.18/
> > >               ide.2.4.18-rc1.02152002.patch.bz2
> > 
> > but ...
> > 
> > how can that work? i mean - 48bit addressing is in the udma133 standard
> > but not in udma100...
> > 
> > how does the /proc/mdstat and /proc/partitions look?
> 
> I am not in front of the machine, but let me tell you that mdstat shows
> a full 480GB RAID5. There are no partitions (hde/g/i/k are used raw).
> 
> Again, I think udma133 and 48bit addressing are two, independent issues.
> The first is an electronic spec for the hardware, the second is an api
> standard which, it seems, can run at any speed.
> 
> Maybe Andre can make a clear statement here?

You're right.

-- 
Vojtech Pavlik
SuSE Labs
