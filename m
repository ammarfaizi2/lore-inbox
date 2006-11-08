Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965563AbWKHMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965563AbWKHMEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbWKHMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:04:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38368 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754537AbWKHMEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:04:44 -0500
Date: Wed, 8 Nov 2006 13:04:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced up
Message-ID: <20061108120407.GA9506@elf.ucw.cz>
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz> <4550AB7A.10508@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4550AB7A.10508@intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>This behavior differs from every other network card, and is also present 
> >>in the
> >>7.3* version of the driver from sourceforge.
> >>
> >>I think the e1000 should try to raise the link during the probe, so that 
> >>it
> >>works properly, without having to set ifconfig ethX up first.
> >
> >I think you should cc e1000 maintainers, and perhaps provide a patch....
> 
> I've read it and not come up with an answer due to some other issues at 
> hand. E1000 hardware works differently and this has been asked before, but 
> the cards itself are in low power state when down. Changing this to bring 
> up the link would make the card start to consume lots more power, which 
> would automatically suck enormously for anyone using a laptop.

Well, maybe E1000 should behave as the other cards behave, and
different solution needs to be found for power saving? ifconfig eth0
suspend?

									Pavel
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
