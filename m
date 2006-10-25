Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423091AbWJYHHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423091AbWJYHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423090AbWJYHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:07:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21398 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423083AbWJYHHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:07:24 -0400
Date: Wed, 25 Oct 2006 09:07:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Yu Luming <luming.yu@gmail.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, len.brown@intel.com,
       Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061025070713.GF5851@elf.ucw.cz>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061010161012.GA18847@lists.us.dell.com> <200610120028.29617.luming.yu@gmail.com> <200610170145.03779.luming.yu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610170145.03779.luming.yu@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > a generic ACPI driver that exports the _BCL and _BCM method
> > > implementations via that same interface, so that systems providing
> > > that will "just work".  drivers/acpi/video.c currently exports this
> > > via /proc/acpi/video/$DEVICE/brightness, which isn't the same as
> > > /sys/class/backlight. :-(
> >
> > Yes, I'm working on acpi video driver transition , and have posted a patch
> > to user backlight for acpi video driver.
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=115574087203605&w=2
> 
> Just updated the backlight and output sysfs support for ACPI Video driver on
> bugzilla. If you are interested this, please take a look at
> http://bugzilla.kernel.org/show_bug.cgi?id=5749#c18

> [patch 1/3] vidoe sysfs support: Add dev argument for baclight sys dev

Two typos in one line :-).

> [patch 2/3] Add display output class support

I guess this needs Documentation/ so we can tell if user<->kernel
interface is sane..

> [patch 3/3] backlight and output sysfs support for acpi video driver

Some whitespace is not okay there...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
