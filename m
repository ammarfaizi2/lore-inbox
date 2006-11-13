Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755263AbWKMRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbWKMRHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbWKMRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:07:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29357 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1755263AbWKMRHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:07:10 -0500
Date: Mon, 13 Nov 2006 18:07:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061113170708.GC23917@atrey.karlin.mff.cuni.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Then the radeonfb doesn't kick in at all (guess some pci ids are 
> > > > added in that patch).
> > > > 
> > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > 
> > > In that case (vesafb), when does the screen come back 
> > precisely ? Do 
> > > you get console mode back and then X ? Or it only comes back when 
> > > going back to X ? Do you have some userland-type vbetool 
> > thingy that 
> > > bring it back ?
> > 
> > He's using s3_bios+s3_mode, so kernel does some BIOS calls to 
> > reinit the video. It should come out in text mode, too.
> > 
> > Christian, can you unload radeonfb before suspend/reload it 
> > after resume?
> 
> Will it work if radeonfb is compiled as module? I think I had problems
> with that, but I'll try again.

I think it could. Be sure to compile vga text-mode support into
kernel.

-- 
Thanks, Sharp!
