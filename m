Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbRLHBLg>; Fri, 7 Dec 2001 20:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285721AbRLHBLR>; Fri, 7 Dec 2001 20:11:17 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:16380 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S285720AbRLHBLP>; Fri, 7 Dec 2001 20:11:15 -0500
Subject: Re: Linux 2.4.17-pre6 drm-4.0
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 7 Dec 2001 16:12:40 -0800 (PST)
Cc: rml@tech9.net (Robert Love), linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <4719.1007767953@ocs3.intra.ocs.com.au> from "Keith Owens" at Dec 08, 2001 10:32:33 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011208001240.A9C5089EF4@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus ditched drm 4.0 months ago.  It only survives in arch add on
> patches like ia64 and in -ac trees.

No, it also survives as an add-on tarball for the standard kernel:
http://www.kernel.org/pub/linux/kernel/v2.4/drm-4.0.x.tar.bz2

Let me dig through my old mail so I can quote Linus on this... Here's
what he said in his Linux 2.4.8 announcement message (Subject
"Linux-2.4.8", sent on August 10th of this year):

> Ok, this one has various VM niceness tweaks that have made some people
> much happier. It also does a upgrade to the XFree86-4.1.x style DRM code,
> which means that people with XFree86-4.0.x can no longer use the built-in
> kernel DRM by default.
> 
> However, never fear. It's actually very easy to get the old DRM code too:
> if you used to use the standard kernel DRM and do not want to upgrade to a
> new XFree86 setup, just get the "drm-4.0.x" package from the same place
> you get the kernel from, and do
> 
>  - unpack the kernel
>  - cd linux/drivers/char
>  - unpack the "drm-4.0.x" package here
>  - mv drm new-drm
>  - mv drm-4.0.x drm
> 
> and you should be all set.

The impression I get (for 2.4) is that DRM 4.1 comes standard but you
should still be able to use 4.0 if you want, via that tarball.

-Barry K. Nathan <barryn@pobox.com>
