Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272991AbTHKTCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272963AbTHKTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:01:21 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:42455 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272991AbTHKTAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:00:24 -0400
Date: Mon, 11 Aug 2003 20:59:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Gerd Knorr <kraxel@suse.de>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       lirc-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811185914.GK2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <20030811183132.GB17777@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811183132.GB17777@bytesex.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I converted lirc_gpio into input/ layer (and killed support for
> > hardware I do not have; sorry but it was essential to keep code
> > small). Ported driver looks like this; I believe it looks better than
> > old code. Patch is here.
> 
> And IMHO it will be even better if it is linked directly into the bttv
> driver and bttv itself registers as input device.  All the complicated
> probing using the functions exported by bttv will go away.  The whole
> construct is only needed because lirc isn't part of the standard
> kernel ...

Yes, that might be even better. I'd like to have ir drivers at one
place, but if theres enough advantage the other way...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
