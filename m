Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUGOGA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUGOGA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUGOGA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:00:26 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:49035 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266048AbUGOGAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:00:20 -0400
Date: Thu, 15 Jul 2004 08:00:17 +0200
From: David Weinehall <tao@debian.org>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040715060017.GG22472@khan.acc.umu.se>
Mail-Followup-To: John Goerzen <jgoerzen@complete.org>,
	linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <20040714202700.GF22472@khan.acc.umu.se> <20040714204527.GA31038@excelhustler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714204527.GA31038@excelhustler.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 03:45:27PM -0500, John Goerzen wrote:
> On Wed, Jul 14, 2004 at 10:27:00PM +0200, David Weinehall wrote:
> > On Wed, Jul 14, 2004 at 08:16:55PM +0000, John Goerzen wrote:
> > > I'm glad I'm not the only one that is suspecting that.  I just tried
> > > switching my T40p from APM to ACPI.  I got suspending to RAM working in
> > > ACPI, but noticed that when I got it back out of my laptop bag later, it
> > > was physically warm to the touch.  It also had consumed more battery
> > > power than it would have when suspended with APM.  And, if I would shine
> > > a bright light on the screen, I could make out text on it.  In other
> > > words, the backlight was off but it was still displaying stuff.
> > 
> > Does poweroff work for you?  At least my T40 has problems shutting off
> > properly when using 2.6 + ACPI.  A bit annoying; I have to keep the
> > powerkey pressed for a few seconds for it to turn off.
> 
> The only way I ever turn the machine off is by running the halt command,
> and that is working fine for me.  I haven't tried the power key.

I meant using the halt command (or rather shutdown -h now, since I've
learned not to expect halt to perform a proper shutdown sequence on
other Unixen).  I must have something strange going on with my
installation then, since it doesn't work for me...  Debugging time!


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
