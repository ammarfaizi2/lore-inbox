Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUGVV2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUGVV2C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 17:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUGVV2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 17:28:02 -0400
Received: from hell.org.pl ([212.244.218.42]:39438 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S267285AbUGVV17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 17:27:59 -0400
Date: Thu, 22 Jul 2004 23:28:03 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: Video memory corruption during suspend
Message-ID: <20040722212803.GA18164@hell.org.pl>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
References: <20040718225247.GA30971@hell.org.pl> <20040722161047.GB15145@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040722161047.GB15145@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Pavel Machek:
> > My setup is:
> > ASUS L3800C laptop, Radeon M7, i845 chipset, using DRI and radeonfb.
[...]
> So what happens on 2.6.7 with swsusp1? Can you try vesafb (and fbdev
> Xserver)?

I don't have 2.6.7-vanilla at hand, but if 2.6.7-mm6 counts then yes,
swsusp1 also triggers that. Note that it doesn't seem to occur when DRI is
not actively used -- the radeon driver code takes quite a long time (up to
4 secs.) to switch to a text VT depending on circumstances, namely when KDE
is up. A plain windowmaker dekstop takes much shorter to switch.

As I'm leaving tomorrow, I won't have time to test with vesafb / fbdev
until next week.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
