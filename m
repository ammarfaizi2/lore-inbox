Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290706AbSAYPeA>; Fri, 25 Jan 2002 10:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290708AbSAYPdj>; Fri, 25 Jan 2002 10:33:39 -0500
Received: from [213.38.169.194] ([213.38.169.194]:40461 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S290706AbSAYPdb>; Fri, 25 Jan 2002 10:33:31 -0500
Message-ID: <AFE36742FF57D411862500508BDE8DD00199532C@mail.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] head.S
Date: Fri, 25 Jan 2002 15:40:05 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Definitely one for Rik's patch of the year archive.

And now we can argue over "licence" and "license".

Phil
---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: John Levon [mailto:movement@marcelothewonderpenguin.com]
> Sent: 25 January 2002 13:43
> To: linux-kernel@vger.kernel.org
> Subject: [PATCH] head.S
> 
> 
> 
> 007 has a license to kill, not a right.
> 
> enjoy,
> john
> 
> 
> --- arch/i386/kernel/head.S.old	Fri Jan 25 13:36:09 2002
> +++ arch/i386/kernel/head.S	Fri Jan 25 13:36:49 2002
> @@ -82,8 +82,8 @@
>   * Initialize page tables
>   */
>  	movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
> -	movl $007,%eax		/* "007" doesn't mean with 
> right to kill, but
> -				   PRESENT+RW+USER */
> +	movl $007,%eax		/* "007" doesn't mean with 
> license to kill, 
> +				 * but PRESENT+RW+USER */
>  2:	stosl
>  	add $0x1000,%eax
>  	cmp $empty_zero_page-__PAGE_OFFSET,%edi
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
