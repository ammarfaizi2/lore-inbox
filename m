Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTKFI1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTKFI1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:27:23 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:1475 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263424AbTKFI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:27:21 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Egger <degger@tarantel.rz.fh-muenchen.de>
Cc: Daniel Egger <degger@fhm.edu>, Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031106090132.B18367@tarantel.rz.fh-muenchen.de>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston> <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston> <1067976347.945.4.camel@sonja>
	 <1068078504.692.175.camel@gaston>
	 <20031106090132.B18367@tarantel.rz.fh-muenchen.de>
Content-Type: text/plain
Message-Id: <1068107179.692.200.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 19:26:19 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-06 at 19:01, Daniel Egger wrote:

> This is probably it. The raw image is just a bit over 4 megs. Is there a
> chance that this will change upstream? Also a warning would be nice while
> creating the kernel as I'm probably not the only one experiencing this.

Ethan doesn't want that change upstream for 1.x, at least not until
it has been mode widely tested. The 1.x yaboot code base isn't something
I'd call "solid", so... :)

> Size problem? At least it's not triggered by the yaboot limitation because
> the image is similar in size to zImage.chrp which would be around 1.8 megs.

No, different issues, but I expect a 1.8 Mb vmlinux.elf-pmac to work,
though it's possible that the wrapper in linus tree is bogus (I though
I sent him fixes... it's beeing difficult to merge anything in 2.6 at
this point).

For PowerMac in general, you'd rather use my tree, at least until maybe
around 2.6.1, and even then... Especially for such very new machine for
which the proper support is only getting in now.

Ben.


