Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268928AbTBSPeS>; Wed, 19 Feb 2003 10:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268938AbTBSPeS>; Wed, 19 Feb 2003 10:34:18 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:34182 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268928AbTBSPeR>; Wed, 19 Feb 2003 10:34:17 -0500
Date: Wed, 19 Feb 2003 03:43:34 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate,
 complete selectable submenu
In-Reply-To: <Pine.LNX.3.96.1030219084918.9798A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0302190332200.4923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Bill Davidsen wrote:

> I don't think it matters, the idea is to avoid all the low-level SCSI
> menus in one place, without disabling the ability to handle ATAPI devices.
> Using the ide-scsi or not still uses SCSI drivers AFAIK.
> 
> > There was talk about it awhile back on the list.  I've been burning CDs 
> > using ide cdrom support for several kernel revisions now.
> 
> Have you checked/used them? I kind of wrote that off after a while, I
> don't need more coasters :-( At the time I deferred testing the score was
> CD: read okay burn failed, ide-floppy (ZIP in my case): ng, and tape: not
> even visible. That was back around 2.5.52 or so, since ide-scsi seems to
> work I haven't been motivated to care.

As I said, I've been using it successfully.  I've not tested ide-floppy 
since I don't have one, nor a tape.  I would rather not have to use 
ide-scsi if I can help it.  ide cd support is incompatible with ide-scsi 
cdrom support, so things are simpler if I can just cut out the scsi 
support entirely.

