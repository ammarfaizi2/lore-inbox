Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVB1RmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVB1RmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVB1RmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:42:00 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:53403 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261708AbVB1Rlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:41:45 -0500
Date: Mon, 28 Feb 2005 18:40:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michal Januszewski <spock@gentoo.org>, mls@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050228174015.GB1349@elf.ucw.cz>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219011433.GA5954@spock.one.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just in case someone is interested, this is bootsplash for 2.6.11-rc4,
> > taken from suse kernel. I'll probably try to modify it to work with
> > radeonfb.
> > 
> > Any ideas why bootsplash needs to hack into vesafb? It only uses
> > vesafb_ops to test against them before some kind of free...
> 
> It doesn't really need vesafb for anything. Back in the days of 2.6.7 
> I used to release a version of bootsplash that had the dep. on vesafb 
> removed. It worked fine with at least some other fb drivers.
> 
> You might also want to save yourself some work and try out an
> alternative solution called fbsplash [1], which I designed after I got 
> tired of fixing bootsplash and which I actively maintain. Fbsplash 
> provides virtually the same functionality, and it has as much code as 
> possible moved into userspace (no more JPEG decoders in the kernel).

mls suggested that there were some problems with matroxfb in the
past. Have you seen something like that?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
