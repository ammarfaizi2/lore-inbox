Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSLKJTO>; Wed, 11 Dec 2002 04:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbSLKJTN>; Wed, 11 Dec 2002 04:19:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:375 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267083AbSLKJTN>; Wed, 11 Dec 2002 04:19:13 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Stian Jordet <liste@jordet.nu>,
       Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.51
References: <Pine.LNX.4.33.0212101016280.2617-100000@maxwell.earthlink.net>
	<1039547936.538.5.camel@zion>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Dec 2002 02:25:21 -0700
In-Reply-To: <1039547936.538.5.camel@zion>
Message-ID: <m1smx4vrem.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2002-12-10 at 19:16, James Simmons wrote:
> > 
> > > > I can take care of radeon's. Did you already used my updated version
> > > > from the PPC tree ?
> > >
> > > Will the Radeon fbdev driver work with all Radeons (for instance a
> > > Radeon 9700 Pro)?
> > 
> > Yes I saw support for this card :-)
> 
> Well, I'm not sure it quite works yet. Maybe unaccelerated, but anyway,
> my version of radeonfb for 2.5 isn't accelerated yet anyway. I'll work
> on that (or Ani will) now that the API is stable enough.

How well does this driver work if you don't have a firmware
driver initialize the card? aka a pci option ROM.

I am interested because with LinuxBIOS it is still a pain to run
PCI option roms, and I don't necessarily even have then if it a
motherboard with video.  There are some embedded/non-x86 platforms
with similar issues.  

My primary interest is in the cheap ATI Rage XL chip that is on many
server board. PCI Vendor/device  id 1002:4752 (rev 27) from lspci.

If nothing else if some one could point me to some resources on
how to get the appropriate documentation from the video chipset
manufacturers I would be happy.

But I did want to at least point that running a system with out bios
initialized video was certainly among the cases that are used.

Eric
