Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbTGNTrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270760AbTGNTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:47:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29667 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270759AbTGNTrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:47:22 -0400
Date: Mon, 14 Jul 2003 22:01:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: linux-kernel@vger.kernel.org,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Re: Hotplug USB mouse bugs in 2.4+swsusp
Message-ID: <20030714200155.GA24964@ucw.cz>
References: <200307110916.13785.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307110916.13785.EricAltendorf@orst.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 09:16:13AM -0700, Eric Altendorf wrote:

> 1) 
> The mouse, under normal operation at times of heavy CPU or disk usage, 
> will be spontaneously lost.  No messages are issued.  Physically 
> unplugging and re-plugging the mouse restores it.

Can be anything, from lost interrupts to noise on the USB connection.
Need more data.

> 2) 
> No matter what I've tried, after switching to using hotplug 
> (previously I had been using the 2.5 kernel w/o the hotplug daemon), 
> I have been unable to get the internal pointer multiplexed into 
> /dev/input/mice.  USB mouse shows up under /dev/input/mice and 
> internal pointer shows up under /dev/psaux only.

Not possible. They're handled by the very same code in 2.5.

> 3)
> After suspend & resume, USB mouse is gone.  Physically replugging it 
> doesn't help.  /etc/init.d/hotplug restart  fixes it.

No idea here. Too many scripts involved.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
