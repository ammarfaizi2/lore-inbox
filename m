Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUK0QUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUK0QUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUK0QUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:20:34 -0500
Received: from gprs214-10.eurotel.cz ([160.218.214.10]:33664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261249AbUK0QUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:20:20 -0500
Date: Sat, 27 Nov 2004 17:20:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
Message-ID: <20041127162001.GB1012@elf.ucw.cz>
References: <20041127072224.GM1417@openzaurus.ucw.cz> <E1CXyvo-0002LS-00@gondolin.me.apana.org.au> <E1CY2Vm-0004LQ-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CY2Vm-0004LQ-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Given it is not too intrusive... why not. Send it for comments.
> >> I probably will not use this myself, so you'll need to test/maintain
> >> it.
> > 
> > This shouldn't be necessary.  Since the resume is being initiated by
> > userspace, it can perform the function of name_to_dev_t and just feed
> > the numbers to the kernel.  The code to do that is still in Debian's
> > initrd-tools.
> 
> Good point. Ok, what's the best way to present this to userspace? Add a
> /sys/power/resume and then echo a major:minor in there?

Yes, that sounds reasonable. Plus docuementation and big warning about
usage of /sys/power/resume...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
