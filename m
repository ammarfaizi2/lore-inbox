Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUK1RVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUK1RVw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUK1RUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:20:00 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:11906 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261539AbUK1RRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:17:36 -0500
Date: Sun, 28 Nov 2004 18:17:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp kconfig: Change in wording (fwd)
Message-ID: <20041128171721.GE1214@elf.ucw.cz>
References: <20041126113040.GB1028@elf.ucw.cz> <41AA02AC.3070200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AA02AC.3070200@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >           Right now you may boot without resuming and then later resume but
> >           in meantime you cannot use those swap partitions/files which were
> 
> Is this still true? Don't we kill the image early, even with "noresume"?
> It is of course possible by omitting the "resume=" parameter, but not
> for the faint of heart ;-)

You are right, user would have to remove resume= parameter, and we do
not want users to do this kind of tricks, so this probably has no
place in configure.help.... Feel free to send followup patch when the
dust settles.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
