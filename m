Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTFVIr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTFVIr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:47:29 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:21940 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264328AbTFVIrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:47:23 -0400
Date: Sun, 22 Jun 2003 10:02:23 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: Adam Majer <adamm@galacticasoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 crash
Message-Id: <20030622100223.13c25efb.dave.bentham@ntlworld.com>
In-Reply-To: <20030622034132.GA4854@galacticasoftware.com>
References: <200306162148.h5GLmXsN002578@telekon.davesnet>
	<20030622034132.GA4854@galacticasoftware.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003 22:41:32 -0500
Adam Majer <adamm@galacticasoftware.com> wrote:

> On Mon, Jun 16, 2003 at 10:48:33PM +0100, dave.bentham@ntlworld.com
> wrote:
> > Hello
> > 
> > But there seems to be a major failure when the computer just stops
> > with no warning. Two scenarios that seem to repeat it include
> > starting Loki's Heretic2 off, and mounting the CDRW drive via
> > WindowMaker dock app. I cannot do anything when this happens; can't
> > hotkey out of X, can't telnet to it from my other networked PC. I
> > have to power down and back up.
> 
> There was something like this posted on the list a few days ago.
> Someone said that it has to do with IDE-SCSI timing or what not. That
> is, try if you can reproduce it without the ide-scsi driver in the
> kernel..

You may be right - I turned off SCSI support in the kernel and removed
the'hdd=ide-scsi' boot appendage and I could mount the CDRW ok.

I'll try and find the history of this known bug.

> 
> > It seems to be a few seconds after the trigger that the lock up
> > occurs, and also it starts flashing the keyboard Caps Lock and
> > Scroll Lock LEDs in step at about 1 Hz. I'm sure its trying to tell
> > me something...
> 
> That means the kernel detected something evil (oops caused by null
> pointer access, etc...). Sicne the leds are still flashing, at least
> the kernel is not totally dead. :)
> 

It may as well be totally dead!!!

Thanks
Dave
