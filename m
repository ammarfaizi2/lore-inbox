Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRDGSwc>; Sat, 7 Apr 2001 14:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRDGSwW>; Sat, 7 Apr 2001 14:52:22 -0400
Received: from [194.213.32.137] ([194.213.32.137]:7684 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129478AbRDGSwM>;
	Sat, 7 Apr 2001 14:52:12 -0400
Date: Thu, 5 Apr 2001 10:24:55 +0000
From: Pavel Machek <pavel@suse.cz>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vik Heyndrickx <vik.heyndrickx@pandora.be>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernel hangs on 486 machine at boot
Message-ID: <20010405102454.A31@(none)>
In-Reply-To: <E14krU0-0002P8-00@the-village.bc.nu> <3ACB6524.C5986233@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3ACB6524.C5986233@didntduck.org>; from bgerst@didntduck.org on Wed, Apr 04, 2001 at 02:17:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Problem: Linux kernel 2.4 consistently hangs at boot on 486 machine
> > >
> > > Shortly after lilo starts the kernel it hangs at the following message:
> > > Checking if this processor honours the WP bit even in supervisor mode...
> > > <blinking cursor>
> > 
> > Does this happen on 2.4.3-ac kernel trees ? I thought i had it zapped
> 
> Yes, that fix in -ac should take care of it.  As to why only the 486
> showed the problem, most 386's will not fault on the write protected
> page (the whole reason for this test) and pentiums and later don't run
> the test at all (assumed good).

We should not "assume good" -- to catch bugs like this one.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

