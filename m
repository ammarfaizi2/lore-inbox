Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRKFQCE>; Tue, 6 Nov 2001 11:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279728AbRKFQBp>; Tue, 6 Nov 2001 11:01:45 -0500
Received: from [198.17.35.35] ([198.17.35.35]:17590 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S279749AbRKFQBg>;
	Tue, 6 Nov 2001 11:01:36 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2863@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: linux-kernel@vger.kernel.org
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, roy@karlsbakk.net
Subject: RE: Mylex/Compaq RAID controller placement in config
Date: Tue, 6 Nov 2001 08:01:31 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well we could simplify it further by putting all
> configuration options under a single menu called
> "things". The controllers under block  dont have
> drives appearing as /dev/sd*

I can understand the initial complaint, but I think it
comes down to a problem of user vs. developer :

For example : All of the SCSI devices are block devices,
aren't they?  So how come they're not under "block devices"
in the menu?

All of the devices under "block devices" are storage controllers
(or ways of accessing storage in linux) so how come they're not
listed as such in the menuconfig options?

and then you hit the whole I20 problem.  Half my raid controllers
aren't under either of those two menus.

Maybe ESR's config method would allow for a way of presenting the
menus in different ways?  One for developers (who care more about
the subsystems and how they're connected) and one for users, who
care more about what the device does then how it's written?

--
Dana Lacoste       Linux Developer
Peregrine Systems   Ottawa, Canada
