Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVKCDM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVKCDM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVKCDM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:12:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21693
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030308AbVKCDMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:12:25 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Robert Schwebel <robert@schwebel.de>
Subject: Re: best way to handle LEDs
Date: Wed, 2 Nov 2005 21:09:55 -0600
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@suse.cz>, Robert Schwebel <r.schwebel@pengutronix.de>,
       vojtech@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
References: <20051101234459.GA443@elf.ucw.cz> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de>
In-Reply-To: <20051102213354.GO23316@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022109.57214.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 15:33, Robert Schwebel wrote:
> On Wed, Nov 02, 2005 at 10:13:34PM +0100, Pavel Machek wrote:
> > We have some leds that are *not* on GPIO pins (like driven by
> > ACPI). We'd like to support those, too.
>
> One more argument to have a LED framework which sits ontop of a lowlevel
> one.

In which case, why not submit the standalone LED framework now and shoehorn 
the low-level one underneath later.  From a userspace API perspective, it 
really shouldn't matter...

Rob
