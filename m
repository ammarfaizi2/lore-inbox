Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTINXHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 19:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbTINXHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 19:07:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53256 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262046AbTINXHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 19:07:48 -0400
Date: Mon, 15 Sep 2003 00:07:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Ethernet cards
Message-ID: <20030915000745.A6789@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60> <20030914091702.B20889@flint.arm.linux.org.uk> <1f4b01c37aad$53675e40$2dee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1f4b01c37aad$53675e40$2dee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Sep 14, 2003 at 07:45:14PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 07:45:14PM +0900, Norman Diamond wrote:
> "Russell King" <rmk@arm.linux.org.uk> replied to me:
> 
> > > Shutting down PCMCIA unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > [...]
> > > The only way to shut down at this point is to turn off the power.
> >
> > IIRC the problem is your hotplug scripts.  Maybe the hotplug folk can tell
> > you the minimum version for 2.6.
> 
> Then I wonder why the interface came up automatically when the card was
> inserted.  By the way the relevant module is pcnet_cs, which is 16-bit
> PCMCIA.  I didn't guess that the hotplug scripts were used for that.  But
> I'll try to find time to test it with new hotplug scripts some weekend.
> 
> (Can't do it now, I'm in the middle of installing SuSE 8.2 on that machine.)

I'll "remind" the linux-net mailing list about this outstanding problem.
It would be nice if some of the net people looked into this bug which,
according to my mailbox, has been hanging around since 16th June...

There comes a point when one guy has to say "I've dealt enough with this
problem" and that time is now.  linux-net - please investigate this weird
usage count bug.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
