Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272954AbTGaJtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272960AbTGaJtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:49:20 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:58068 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272954AbTGaJtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:49:17 -0400
Date: Thu, 31 Jul 2003 11:49:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731094904.GC464@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F288CAB.6020401@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  - APM uses the pm_*() calls for a vetoable check,
>    never issues SAVE_STATE, then goes POWER_DOWN.

I remember the reason... SAVE_STATE expects user processes to be
stopped, which is not the case in APM. Perhaps that is easy to fix
these days...
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
