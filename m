Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTBTQrU>; Thu, 20 Feb 2003 11:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTBTQrU>; Thu, 20 Feb 2003 11:47:20 -0500
Received: from [213.38.169.194] ([213.38.169.194]:59912 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S266010AbTBTQrS>; Thu, 20 Feb 2003 11:47:18 -0500
Message-ID: <0EBC45FCABFC95428EBFC3A51B368C95513641@jessica.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.20 amd speculative caching
Date: Thu, 20 Feb 2003 16:49:34 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Richard Brunner of AMD's email to the list dated June 11, 2002,
the cache attribute bug only affected Athlon XPs and MPs, so that can't be
the problem here, can it?

Cheers,

Phil

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: Dave Jones [mailto:davej@codemonkey.org.uk]
> Sent: 20 February 2003 16:53
> To: Sowadski, Craig Harold (UMR-Student)
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: 2.4.20 amd speculative caching
> 
> 
> On Wed, Feb 19, 2003 at 01:13:28PM -0600, Sowadski, Craig 
> Harold (UMR-Student) wrote:
> 
>  > If it helps, here is my hardware config:
>  > 
>  > 	AMD Duron 1300MHZ
>  > 	MSI K7T Turbo-2
>  > 	ATI Radeon 7500 w/64mb
>  > 	Redhat 8.0
> 
> Are you using the ATi firegl drivers ? If so, thats likely the
> problem. (They ship an agpgart based upon 2.4.16 which lacks
> the fixes needed).
> 
> 		Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
