Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSHTVxl>; Tue, 20 Aug 2002 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSHTVxl>; Tue, 20 Aug 2002 17:53:41 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59397
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317398AbSHTVxk>; Tue, 20 Aug 2002 17:53:40 -0400
Date: Tue, 20 Aug 2002 14:57:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
cc: "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: RE: IDE-flash device and hard disk on same controller
In-Reply-To: <A9713061F01AD411B0F700D0B746CA6802FC1464@vacho6misge.cho.ge.com>
Message-ID: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Heater, Daniel (IndSys, GEFanuc, VMIC) wrote:

> 
> OK. hdc=flash works where hdc=hard drive and hdd=CompactFlash.
> 
> Thanks Padraig.
> 
> I guess it's 6 of one, half-dozen the other, but telling the kernel that my
> hard drive is a flash drive just makes me feel squidgy!  I'm still inclined
> to suggest that the test that _prevents_ hard drive + CF configuration is no
> longer appropriate now that _some_ (most??) hardware vendors have figured
> out how to get ide-flash devices to work without "hanging" when no second
> device is present. Users with incompatible hardware can still prevent the
> long system hang by using hdx=none.

That is sounds reasonable and something for just before final 2.6.

> I also used this workaround (hdb=flash) to configure a system with hda=flash
> and hdb=cdrom.  This seems to work also.  Are there any side effects to
> telling the kernel that the hard drive or cdrom is a flash device (such as
> marking it removable or not marking it removable)?

EWW that is nasty, and there is another ace I will put out for this
occassion

JG! this is where those long nights of explain the spec to you and getting
that one opcode functional will go.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

