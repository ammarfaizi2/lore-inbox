Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTKONXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTKONXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:23:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25616 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261699AbTKONXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:23:45 -0500
Date: Sat, 15 Nov 2003 08:13:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031113070627.GU21141@suse.de>
Message-ID: <Pine.LNX.3.96.1031115080431.2903C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Jens Axboe wrote:

> On Wed, Nov 12 2003, bill davidsen wrote:

> > capability working again. I presume eventually one of the commercial
> > vendors will fix it, since it's easier than rewriting all the SCSI
> > applications in the world. oddly there are people writing useful things
> > using other operating systems, under 2.4 almost all of those work.
> 
> It's not about applications, we can fix that differently. You still
> don't seem to get that moving from ide-scsi is a _good_ thing, from the
> application point of view. It's about hardware that doesn't work well
> with atapi drivers yet, for whatever reason. ide-scsi is nice to have to
> fill those holes.

Sorry, as far as I can tell it's just the wrong direction. Devices mounted
by USB look like... SCSI. And ZIP drives and tapes mounted on parallel
(ppa) look like... SCSI. If Linux had one fully functional ide-scsi driver
it would then present a consistant all-SCSI interface to the applications.
No more ide-floppy, ide-cd, ide-tape, just one driver. And that would
allow use of applications from BSD, Sun, and SysV.

Clearly the ide-scsi driver currently available isn't fully capable, and
as long as Linus doesn't agree that having a single application interface
is elegant and desirable, I can't see anyone doing the things needed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

