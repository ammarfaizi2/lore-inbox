Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268956AbTBSR5m>; Wed, 19 Feb 2003 12:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTBSR5m>; Wed, 19 Feb 2003 12:57:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64260 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268956AbTBSR5k>; Wed, 19 Feb 2003 12:57:40 -0500
Date: Wed, 19 Feb 2003 13:04:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Molina <tmolina@cox.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
In-Reply-To: <Pine.LNX.4.44.0302190332200.4923-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1030219130140.10611E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Thomas Molina wrote:

> On Wed, 19 Feb 2003, Bill Davidsen wrote:

> > Have you checked/used them? I kind of wrote that off after a while, I
> > don't need more coasters :-( At the time I deferred testing the score was
> > CD: read okay burn failed, ide-floppy (ZIP in my case): ng, and tape: not
> > even visible. That was back around 2.5.52 or so, since ide-scsi seems to
> > work I haven't been motivated to care.
> 
> As I said, I've been using it successfully.  I've not tested ide-floppy 
> since I don't have one, nor a tape.  I would rather not have to use 
> ide-scsi if I can help it.  ide cd support is incompatible with ide-scsi 
> cdrom support, so things are simpler if I can just cut out the scsi 
> support entirely.

Since I have SCSI devices I'd rather make the ATAPI devices look SCSI than
have two sets of tools to do things. And two sets of drivers loaded, two
sources of possible bugs, etc. That just seems simpler to me.

Thanks for the input.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

