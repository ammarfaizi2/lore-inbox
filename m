Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272898AbTHEWLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272894AbTHEWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:11:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4325 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272893AbTHEWL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:11:27 -0400
Date: Fri, 1 Aug 2003 11:33:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030801093324.GK2601@openzaurus.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059689105.2417.195.camel@gaston> <20030731220958.GA459@elf.ucw.cz> <200308010112.20514.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308010112.20514.oliver@neukum.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > Is not disk spin-down policy, and thus belonging to userspace? Having
> > daemon poll for inactivity of hubs once every 5 minutes and sending
> > them to sleep should not hurt, too...
> > 								Pavel
> 
> Taking precedents into account it is the kernel's job.
> Screen blanking is done in kernel, as is afaik floppy
> motor control.

Floppy motor was not designed to be "always on", and screen gets physically damaged
if you don't turn it off. OTOH harddrives were designed for always on, and if you spin up/down
too much you shorten their lives...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

