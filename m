Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934029AbWKTJSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934029AbWKTJSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933951AbWKTJSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:18:04 -0500
Received: from opal.biophys.uni-duesseldorf.de ([134.99.176.7]:12727 "EHLO
	opal.biophys.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id S933064AbWKTJSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:18:02 -0500
Date: Mon, 20 Nov 2006 10:17:28 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>, adaplas@pol.net,
       James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
In-Reply-To: <20061118195519.GZ31879@stusta.de>
Message-ID: <Pine.LNX.4.58.0611201014280.24134@xplor.biophys.uni-duesseldorf.de>
References: <20061118000235.GV31879@stusta.de>
 <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
 <20061118195519.GZ31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > - FB_ATARI
> >
> > FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
> > the final one soonish.
>
> Thanks for this information.
>
> Are any of the following Atari options that are also on my
> "BROKEN since at least 2.6.0" list also being revived?
>
> - HADES (arch/m68k/Kconfig)
> - ATARI_ACSI (drivers/net/Kconfig)
> - ATARI_BIONET (drivers/net/Kconfig)

These three I can try to 'revive' without actually being able to test
them.

> - ATARI_PAMSNET (drivers/net/Kconfig)
> - ATARI_SCSI (drivers/scsi/Kconfig)

These two (assuming PAMSNET is the VME ethercard) I can even test myself.
So you can mark them 'being worked on'...

	Michael
