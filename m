Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVDXVDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVDXVDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVDXVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:03:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13502 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262421AbVDXVDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:03:18 -0400
Date: Sun, 24 Apr 2005 23:03:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
Message-ID: <20050424210300.GF30088@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl> <20050423220757.GD1884@elf.ucw.cz> <426B7B97.4030009@suse.de> <20050424202230.GC30088@elf.ucw.cz> <426C04E3.9070508@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426C04E3.9070508@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That would not work, anyway. You want the messages from drivers,
> > too... and drivers are not going to prepend "swsusp".
> 
> Yes it would. I do not need driver messages if the reason is "no swap
> partition" or something like that ;-))

Umm, okay. grep -i5 swsusp ... should get most driver messages, too...

> > Ultimately, cleaning up "suspend screen" so that it is not too scary
> > for non-technical users might be nice... It means killing some debug
> > messages from drivers, too.
> 
> I'd just sweep it under the bootsplash carpet. Then we have both:
> possibility to debug and nice progressbar as long as everything works
> fine :-)

I don't like bootsplash... plus I'd like to clean it properly. It
prints too much junk even for me...
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
