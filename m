Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTBSDjV>; Tue, 18 Feb 2003 22:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267966AbTBSDjV>; Tue, 18 Feb 2003 22:39:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39172 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267955AbTBSDjS>; Tue, 18 Feb 2003 22:39:18 -0500
Date: Tue, 18 Feb 2003 22:45:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
In-Reply-To: <20030218152520.A16760@infradead.org>
Message-ID: <Pine.LNX.3.96.1030218224242.7581B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Christoph Hellwig wrote:

> On Tue, Feb 18, 2003 at 02:02:10PM +0100, Marc-Christian Petersen wrote:
> > so you can disable all SCSI lowlevel drivers at once.
> 
> Why? just disable CONFIG_SCSI instead of adding an artifical option

Isn't that going to disable all of SCSI? I think the intention may be to
drop hardware drivers and just use ide-scsi, although I might be
misreading the original intent.

There are a fair number of tape/CD/DVD devices out there which you might
run SCSI. I many cases will run SCSI or not at all.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

