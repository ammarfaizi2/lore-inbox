Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVBQUqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVBQUqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBQUqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:46:36 -0500
Received: from gprs214-47.eurotel.cz ([160.218.214.47]:28545 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262343AbVBQUnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:43:12 -0500
Date: Thu, 17 Feb 2005 21:42:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217204247.GA2386@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net> <20050217195456.GA5963@openzaurus.ucw.cz> <4214FFCE.4080703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214FFCE.4080703@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> >>4. Include a mandantory description of video bringup after resume
> > 
> > That sounds overcomplicated. Simply add this to the specs:
> 
> You have to start to think like a vendor with a long legacy. Then my
> spec draft will make more sense. Basically, you can't tell a vendor
> that his hardware is broken or he will ignore your efforts from that
> point on. "It's a question of honour." If, on the other hand, a
> vendor can claim his products are conforming to the spec by issuing
> a software update for broken hardware, it is much more likely that
> the spec gets accepted.

Well, whether you POST video or not is still only
software... anyway...

Your _WAK idea could work for notebooks (but if you did it in _WAK
you'd break windows, so you'd have to call it _VWK (VideoWaK) or
something), but for desktop where user can plug in any video card he
buys... I do not see how you can get away with something other than
normal POST.

> > BIOS must do that during normal boot; this should be very little
> > additional work.
> 
> Not necessarily. Some BIOSes stay in graphics mode during the whole
> bootup (at least it seems so) and would have to include additional
> code to enter 80x25 text mode.

??? When grub is launched, you are in 80x25 text mode.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
