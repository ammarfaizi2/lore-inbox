Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUGTUS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUGTUS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUGTURe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:17:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46764 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266257AbUGTUMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:12:03 -0400
Date: Tue, 20 Jul 2004 22:12:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: Volker Braun <volker.braun@physik.hu-berlin.de>,
       lkml <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040720201202.GB14684@atrey.karlin.mff.cuni.cz>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <pan.2004.07.14.23.28.53.135582@physik.hu-berlin.de> <20040716170052.GC8264@openzaurus.ucw.cz> <1090352569.2542.1.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090352569.2542.1.camel@bluerat>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > And, if I would shine
> > > > a bright light on the screen, I could make out text on it.  In other
> > > > words, the backlight was off but it was still displaying stuff.
> > > 
> > > I cannot reproduce that (T41), but maybe I'm looking at the wrong angle or
> > > your eyes are better. In any case I understand that this image is very
> > > faint.
> > > 
> > > I'm not sure whether this is actually part of the problem. The
> > > liquid crystals might just keep their current orientation, or there might
> > > be some residual charge in the driver circuit. Do you want to take your
> > > display apart and check with a voltmeter? I dont't :-)
> > 
> > If it is still there after half an hour, its certainly part of the problem.
> > LCD crystals loose the orientation in seconds, IIRC.
> > 				Pavel
> 
> I found that on my T40, if I am using the radeonfb built into the kernel
> I cannot see a ghost image, but if I use VESA or vga=normal, I can see a
> ghost in S3.

Well, you can't really expect to run without driver for hardware
(VESA or vga=normal) and still get hardware powersaved correctly.

							Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
