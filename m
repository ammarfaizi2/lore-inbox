Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270328AbUJUGQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbUJUGQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270259AbUJUGMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:12:50 -0400
Received: from gprs214-236.eurotel.cz ([160.218.214.236]:60547 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S270495AbUJTTpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:45:03 -0400
Date: Wed, 20 Oct 2004 21:44:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tim Cambrant <cambrant@acc.umu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: power/disk.c: small fixups
Message-ID: <20041020194434.GA10239@elf.ucw.cz>
References: <20041020181617.GA29435@elf.ucw.cz> <20041020193741.GA27096@shaka.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020193741.GA27096@shaka.acc.umu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > power_down may never ever fail, so it does not really need to return
> > anything. Kill obsolete code and fixup old comments. Please apply,
> > 
> 
> ...
> 
> > @@ -162,7 +163,7 @@
> >   *
> >   *	If we're going through the firmware, then get it over with quickly.
> >   *
> > - *	If not, then call pmdis to do it's thing, then figure out how
> > + *	If not, then call swsusp to do it's thing, then figure out how
> >   *	to power down the system.
> >   */
> 
> I hate to be picky, but changing "it's" to the more correct "its" would
> perhaps be nice to do when you're at it?

Fixed; I'll propagate it eventually, just will not regenerate current
patch for it, ok?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
