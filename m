Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272473AbRIOSPV>; Sat, 15 Sep 2001 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272483AbRIOSPK>; Sat, 15 Sep 2001 14:15:10 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:7892 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S272473AbRIOSOy>; Sat, 15 Sep 2001 14:14:54 -0400
Date: Sat, 15 Sep 2001 11:15:04 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>, <DevilKin@gmx.net>
Subject: Re: [PATCH] AGP GART for AMD 761
In-Reply-To: <1000577021.32706.29.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109151114200.26946-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 Sep 2001, Robert Love wrote:

> The following patch provides AGP support from the AMD AGP driver for the
> AMD 761.  I don't have an AMD 761 and I had to look the PCI ID up, so I
> need some confirmation this works.  Despite this, it should.
>
> Please test and let me know so I can forward it off.  Against
> 2.4.10-pre9, but should apply to Alan's tree and 2.4.9.

> @@ -2922,7 +2928,6 @@
>  		"Intel",
>  		"440GX",
>  		intel_generic_setup },
> -	/* could we add support for PCI_DEVICE_ID_INTEL_815_1 too ? */
>  	{ PCI_DEVICE_ID_INTEL_815_0,
>  		PCI_VENDOR_ID_INTEL,
>  		INTEL_I815,

What's the story with that chunk?  It looks like you removed a comment
without changing the code, and it is totally unrelated to the AMD 761
problems that you are trying to fix.

-jwb

