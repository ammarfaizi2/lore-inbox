Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVC2KTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVC2KTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVC2KTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:19:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63427 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262278AbVC2KSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:18:36 -0500
Date: Tue, 29 Mar 2005 12:18:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: johnpol@2ka.mipt.ru, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329101816.GA6496@elf.ucw.cz>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com> <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42439839.7060702@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >>See the earlier discussion, when data validation was -removed- from the 
> >>original Intel RNG driver, and moved to userspace.
> >
> >I'm not arguing against userspace validation, but if data produced
> >_is_ cryptographically strong, why revalidate it again?
> 
> You cannot prove this without validating the data in software.
> 
> Otherwise, you are not handling the hardware-fault case.
> 
> It is foolish to presume that hardware always works correctly.  It is 
> -very- foolish to presume this, in cryptography.

We trust hardware, anyway. Like your disk *could* accidentaly turn on
setuid bit on /bin/bash, and we do not insist on userspace
disk-validator.

I do not think paranoia about random generators is neccessary. If
vendor provides you with random generator, it should be ok to just use
it. [Did anyone see failing hw random generator, *at all*?] I can
provide you with plenty of failing hdds....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
