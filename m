Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVALWuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVALWuC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVALWsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:48:39 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:57242 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261527AbVALWq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:46:59 -0500
Date: Wed, 12 Jan 2005 23:46:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Message-ID: <20050112224641.GP1408@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501121951.48102.rjw@sisk.pl> <20050112210147.GJ1408@elf.ucw.cz> <200501122344.20589.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501122344.20589.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > (for example - the second number is always negative and huge).  Would it 
> mean 
> > > that get_cmos_time() needs fixing?
> > 
> > get_cmos_time() looks okay, but timer){suspend,resume} looks
> > hopelessly broken.
> 
> Well, why don't we convert them to noops, then, at least temporarily?

Actually, it was my analysis that was wrong. Did you try Nigel's trick
with updating wall_jiffies?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
