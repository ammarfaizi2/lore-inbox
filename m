Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUGHWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUGHWxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUGHWxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:53:40 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:5249 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261875AbUGHWxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:53:38 -0400
Date: Fri, 9 Jul 2004 00:52:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Erik Rigtorp <erik@rigtorp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040708225216.GA27815@elf.ucw.cz>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708210403.GA18049@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Perhaps CONFIG_BOOTSPLASH should be in mainline after all?
> > I really don't want to see 2 different incompatible sets
> > of hooks into swsusp....
> 
> No.  This stuff has no business in the kernel, paint your fancy graphics
> ontop of fbdev.  And the SuSE bootsplash patch is utter crap, I mean what
> do you have to smoke to put a jpeg decoder into the kernel?

No idea; smoking is prohibited in SuSE offices, so someone external
had to do that ;-).

I have not seen SuSE version of bootsplash... I do not want to
see. But this way, SuSE has its own crappy bootsplash, RedHat probably
too, Mandrake probably too, etc.

And now, SUSE will want splash over swsusp, RedHat probably too,
Madrake probably too, etc. I do not want to deal with 3 different sets
of hooks into swsusp.

Now.. Perhaps cleaned-up bootsplash could find its way into
kernel. That would at least turn down ammount of crap in
distributions. At least there would be unified way to turn that thing
off...

Or at least standartized hooks for various splashes, so that I do not
have to deal with 3 different sets?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
