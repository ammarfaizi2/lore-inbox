Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWG3Kha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWG3Kha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWG3Kha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:37:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53702 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932249AbWG3Kh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:37:29 -0400
Date: Sun, 30 Jul 2006 12:37:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>,
       Mark Underwood <basicmark@yahoo.com>, Jean Delvare <khali@linux-fr.org>
Subject: Re: Generic battery interface
Message-ID: <20060730103715.GD1920@elf.ucw.cz>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com> <20060730100559.GA1920@elf.ucw.cz> <41840b750607300334g2e9cbd56i2b4e5bad285e09c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607300334g2e9cbd56i2b4e5bad285e09c0@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Are there any plans at merging tp_smapi, BTW? After fixing few minor
> >details (like removing " mV" from files)... it looks like it would fit
> >into hwmon infrastructure rather nicely.
> 
> Yes, it will definitely be submitted once stable. We're still tweaking
> some stuff, such as whitelisting (see "[PATCH] DMI: Decode and save
> OEM String information").

Please avoid this trap. You probably want to submit it early. "Submit
once stable" is dangerous: cleanups needed while submitting sometimes
make the whole work unstable, again.

> Is "hwmon" suitable for something that *contols* battery charging too,
> and might have extra attributes tacked on as we unravel additional
> ThinkPad firmware capabilities?

I'd say it is okay. AFAICT, hwmon can already control fan.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
