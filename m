Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937105AbWLFSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937105AbWLFSyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937109AbWLFSyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:54:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60446 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937105AbWLFSyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:54:04 -0500
Date: Wed, 6 Dec 2006 19:54:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Message-ID: <20061206185404.GA3230@atrey.karlin.mff.cuni.cz>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com> <20061201133520.GC4239@ucw.cz> <20061201194337.GA7773@khazad-dum.debian.net> <20061202162352.GD4773@ucw.cz> <Pine.LNX.4.64.0612061525140.28745@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061525140.28745@pentafluge.infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't top-post...

> Its nice to see acpi moving to the backlight api. Will acpi also move to 
> hwmon and led class support ?

It would be nice... ACPI does not drive many leds ... usually ... but
creating battery API based on hwmon and moving ACPI battery support to
that API would certainly be nice... and I believe it is ongoing work.
								Pavel

> > Hi!
> > 
> > > > Looks okay to me. We really want unified interface for backlight.
> > > 
> > > Then I request some help to get
> > > http://article.gmane.org/gmane.linux.acpi.devel/19792
> > > merged.
> > > 
> > > Without it, the backlight interface becomes annoying on laptops.  Your
> > > screen will be powered off when you remove the modules providing the
> > > backlight interface.  This is not consistent with the needs of laptop
> > > backlight devices, or with the behaviour the drivers had before the
> > > backlight sysfs support was added.
> > 
> > Just retransmit it to akpm and list, and add acked-by headers with
> > people who said patch is okay... that included me IIRC.
> > 
> > 

-- 
Thanks, Sharp!
