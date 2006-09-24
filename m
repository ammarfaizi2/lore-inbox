Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWIYOSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWIYOSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIYOSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:18:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18960 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932178AbWIYOSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:18:00 -0400
Date: Sun, 24 Sep 2006 16:21:58 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Gran <alex@grans.eu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: usb still sucks battery in -rc7-mm1
Message-ID: <20060924162158.GB5156@ucw.cz>
References: <20060924090858.GA1852@elf.ucw.cz> <200609241650.02922@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609241650.02922@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24-09-06 16:49:59, Alexander Gran wrote:
> Perhaps your cpu cannot go into deep c states? At least my IBm T40p has that 
> problem, when USB is enabled.

Yes, and latest -mm's were expected to fix that...

							Pavel

> 
> regards
> Alex
> 
> Am Sonntag, 24. September 2006 11:08 schrieb Pavel Machek:
> > Hi!
> >
> > I made some quick experiments, and usb still eats 4W of battery
> > power. (With whole machine eating 9W, that's kind of a big deal)...
> >
> > This particular machine has usb bluetooth, but it can be disabled by
> > firmware, and appears unplugged. (I did that). It also has fingerprint
> > scanner, that can't be disabled, but that does not have driver (only
> > driven by useland, and was unused in this experiment).
> >
> > Any ideas?
> > 								Pavel
> 
> -- 
> Encrypted Mails welcome.
> PGP-Key at http://www.grans.eu/misc/pgpkey.asc | Key-ID: 0x6D7DD291
> More info at http://www.grans.eu/Alexander_Gran.html



-- 
Thanks for all the (sleeping) penguins.
