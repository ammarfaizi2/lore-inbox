Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSKTWo3>; Wed, 20 Nov 2002 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSKTWo3>; Wed, 20 Nov 2002 17:44:29 -0500
Received: from [192.58.209.91] ([192.58.209.91]:36041 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S263026AbSKTWo1>;
	Wed, 20 Nov 2002 17:44:27 -0500
From: George France <france@handhelds.org>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
Subject: Re: [Patch] 2.5.48 Trivial to ../asm-alpha/suspend.h
Date: Wed, 20 Nov 2002 17:51:23 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <02112016143302.13910@shadowfax.middleearth> <20021120223056.A650@Marvin.DL8BCU.ampr.org>
In-Reply-To: <20021120223056.A650@Marvin.DL8BCU.ampr.org>
MIME-Version: 1.0
Message-Id: <02112017512304.13910@shadowfax.middleearth>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 November 2002 17:30, Thorsten Kranzkowski wrote:
> On Wed, Nov 20, 2002 at 04:14:33PM -0500, George France wrote:
> > Fix compilation failure.
> >
> > Best Regards,
> >
> >
> > --George
> >
> > --- linux/include/asm-alpha/suspend.h.orig      Wed Dec 31 19:00:00 1969
> > +++ linux/include/asm-alpha/suspend.h   Wed Nov 20 03:55:57 2002
> > @@ -0,0 +1,4 @@
> > +#ifdef _ASMALPHA_SUSPEND_H
>
> #ifndef I suppose?

At this time it doesn't matter, it is just a dummy include, that I cut and pasted from
../asm-arm/suspend.h.  #ifndef makes more sense.  I should have probably
looked more closely at the code and also probably inserted a "/* dummy include */"
line in between #define and #endif. 

Thank you for paying attention.

Best Regards,


--George
