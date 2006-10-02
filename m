Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWJBRJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWJBRJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWJBRJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:09:10 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:23003 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S965132AbWJBRJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:09:09 -0400
Date: Mon, 2 Oct 2006 10:08:32 -0700
To: Pavel Machek <pavel@ucw.cz>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: wireless abi breakage (was Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA)
Message-ID: <20061002170832.GB14535@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <20060930193853.GA6890@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930193853.GA6890@ucw.cz>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 07:38:53PM +0000, Pavel Machek wrote:
> Hi!
> 
> > 	That's exactly the point of this warning (some distro like to
> > kill it), I think it spells pretty clearly what's wrong. Don't say I
> > did not warn you...
> 
> Well... we are trying to have stable abi here. Breaking older wireless
> tools randomly is *not* okay in the middle of stable series.

	I'm sorry, but as there is no longer any "devel" serie, to me
there is no longer any "stable" serie. Do you mean that we are going
to get frozen with the same APIs until then end of time ? I don't
think so...
	You can see the glass half-full or half-empty. Maybe you can
see that both Wireless Tools and wpa_supplicant compatible with those
changes were released last May, which means by the time this kernel
change hit the distro, people won't notice...

> > 	If you run a custom kernel, I think you won't see any problems
> > running a custom version of Wireless Tools. They are available on my
> > web site, pretty easy to install, and have minimal
> 
> No. Kernel abi is stable in 2.6.x.

	Sure, I saw for examples a few warning about udev API changes.

	Jean
