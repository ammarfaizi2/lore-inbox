Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274887AbTGaV2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274878AbTGaV2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:28:09 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:25127
	"EHLO gaston") by vger.kernel.org with ESMTP id S274877AbTGaV0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:26:32 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3F291857.1030803@pacbell.net>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
	 <20030731094904.GC464@elf.ucw.cz>  <3F291857.1030803@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059686740.2420.158.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 23:25:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 15:23, David Brownell wrote:
> Pavel Machek wrote:
> > Hi!
> > 
> > 
> >> - APM uses the pm_*() calls for a vetoable check,
> >>   never issues SAVE_STATE, then goes POWER_DOWN.
> > 
> > 
> > I remember the reason... SAVE_STATE expects user processes to be
> > stopped, which is not the case in APM. Perhaps that is easy to fix
> > these days...
> > 							Pavel
> 
> 
> That SAVE_STATE restriction doesn't seem to be documented...

Because it is plain wrong ;)

Ben.

