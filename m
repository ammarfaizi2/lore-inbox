Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129341AbRBMAF0>; Mon, 12 Feb 2001 19:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbRBMAFR>; Mon, 12 Feb 2001 19:05:17 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.16]:13272 "EHLO mta5")
	by vger.kernel.org with ESMTP id <S129341AbRBMAFG>;
	Mon, 12 Feb 2001 19:05:06 -0500
Date: Mon, 12 Feb 2001 19:02:05 -0500 (EST)
From: Sean <crisper@optonline.net>
Subject: Re: LARGE bug with 2.4.1ac10 and loop filesystem
In-Reply-To: <E14SRSR-0008JM-00@the-village.bc.nu>
To: linux-kernel@vger.kernel.org
Reply-to: Sean <crisper@optonline.net>
Message-id: <200102130001.f1D01ob13279@s1.optonline.net>
MIME-version: 1.0
X-Mailer: Pronto v2.2.3 On linux/CSV
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
In-Reply-To: <E14SRSR-0008JM-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I just compiled 2.4.1-ac10 with the loop-3 patch from adoeb and it seems to fix
the loopback problems.	This is for someone NOT using the encrypted FS since I
did not test this.

If anyone has a better way to make sure everything is working correctly other
than using mkinitrd to test if the loopback works then please let me know.

Thanks for the fix,

Sean 


On Mon, 12 Feb 2001 22:28:28 +0000 (GMT), Alan Cox said:

> > > That was Im afraid pure luck. Jens is currently sorting out the
>  > > loop problems and has test patches
>  > 
>  > By any chance, are these loop problems the same ones affecting
>  > 2.4.2-pre2 and -pre3?
>  
>  And to varying degrees all 2.4.x kernels right now
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://vger.kernel.org/lkml/
>  
>  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
