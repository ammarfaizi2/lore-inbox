Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271750AbTGXWbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271751AbTGXWbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:31:09 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:10214 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271750AbTGXWbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:31:08 -0400
Date: Fri, 25 Jul 2003 00:46:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brugger <ml.dominik83@gmx.net>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: OHCI problems with suspend/resume
Message-ID: <20030724224600.GB430@elf.ucw.cz>
References: <20030723220805.GA278@elf.ucw.cz> <20030724143731.5fe40b4e.ml.dominik83@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724143731.5fe40b4e.ml.dominik83@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
> > kills machine during secon suspend/resume cycle.
> 
> I experience similar problems with UHCI:
> 
> Before suspending to S3 I unload usb modules and afterwards I reload them, but it does not work again.
> (For testing I also plugged in an USB card reader with an LED.
> The LED is on except when I resume from S3)

Do not unload modules before suspend, they should handle that just
fine.

With uhci on toshiba satelite I can do both S3 and S4, and USB
survives that (at least it is able to power devices and detects
plugs/unplugs).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
