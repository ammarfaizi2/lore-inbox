Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVDEVVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVDEVVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVDEUnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:43:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24743 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262015AbVDEUm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:42:57 -0400
Date: Tue, 5 Apr 2005 22:42:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: LKML <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Message-ID: <20050405204234.GE1380@elf.ucw.cz>
References: <20050405185620.80060.qmail@web88009.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405185620.80060.qmail@web88009.mail.re2.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm working o

???

> > > [4294672.065000] ACPI: CPU0 (power states: C1[C1]
> > C2[C2] C3[C3])
> > > [4294676.827000] ACPI: (supports S0 S3 S4 S5)
> > 
> > 
> > ...aha, but your system does not support S1 aka
> > standby.
> >  
> 
> Right, so nothing should happen if I try to do it, but
> something does only in /proc/acpi/sleep does the
> system attempt S1 which is not supported.

Feel free to fix it :-).

> Do you know if /proc/acpi/sleep will be deprecated in
> favour of /sys/power/state? If so, this thread will be
> moot ;)

No idea, deprecating it would be ok with me. 

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
