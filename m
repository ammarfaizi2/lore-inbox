Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbRIOSVc>; Sat, 15 Sep 2001 14:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272498AbRIOSVX>; Sat, 15 Sep 2001 14:21:23 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:3860 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S272493AbRIOSVN>; Sat, 15 Sep 2001 14:21:13 -0400
Subject: Re: [PATCH] AGP GART for AMD 761
From: Robert Love <rml@tech9.net>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org, DevilKin@gmx.net
In-Reply-To: <Pine.LNX.4.33.0109151114200.26946-100000@windmill.gghcwest.com>
In-Reply-To: <Pine.LNX.4.33.0109151114200.26946-100000@windmill.gghcwest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 14:21:21 -0400
Message-Id: <1000578083.32708.35.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-15 at 14:15, Jeffrey W. Baker wrote:
> > @@ -2922,7 +2928,6 @@
> >  		"Intel",
> >  		"440GX",
> >  		intel_generic_setup },
> > -	/* could we add support for PCI_DEVICE_ID_INTEL_815_1 too ? */
> >  	{ PCI_DEVICE_ID_INTEL_815_0,
> >  		PCI_VENDOR_ID_INTEL,
> >  		INTEL_I815,
> 
> What's the story with that chunk?  It looks like you removed a comment
> without changing the code, and it is totally unrelated to the AMD 761
> problems that you are trying to fix.

It's my comment :)

I wrote the i815 AGP code, too, and I don't know what I was thinking but
there is no need to add support for PCI_DEVICE_ID_INTEL_815_1.

If I send the patch off to Linus, now is a good time to remove it.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

