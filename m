Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbTL3OIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 09:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbTL3OIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 09:08:34 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:37124 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265794AbTL3OId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 09:08:33 -0500
Date: Tue, 30 Dec 2003 15:20:04 +0100
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
Message-ID: <20031230142004.GA14655@hh.idb.hist.no>
References: <200312232342.17532.josh@stack.nl> <20031226233855.GA476@hh.idb.hist.no> <3FECCAF9.7070209@maine.rr.com> <1072507896.27022.226.camel@menion.home> <3FEE47F5.6090406@why.dont.jablowme.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEE47F5.6090406@why.dont.jablowme.net>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 10:03:17PM -0500, Jim Crilly wrote:
> >
> >Sometimes Windows 2k or XP dump (BSOD), or maybe you just get an error. 
> >
> > 
> >
> Generally it just complains that you pulled out the device prematurely, 

Depends on what the device is used for, I guess.

> I've never seen one give a STOP error from that but I guess a bad driver 
> or USB controller could cause anything.
> 
Well, try having a partially loaded system dll on removable
media when you pull the plug - it won't be pretty.

> When you insert a device like a USB stick Windows puts a little icon 
> next to the clock in the system tray that you're supposed to use to stop 
> the device before pulling it, effectively it unmounts and stops (or 
> atleast releases the device from) the driver so the device can be 
> 'safely' removed. I also believe Windows mounts any removable device 
> synchronously so that if you do pull it out prematurely the damage done 
> is limited.

Linux has sync mounts too. :-)  the rest is a gui thing, i.e. not kernel.

Helge Hafting
