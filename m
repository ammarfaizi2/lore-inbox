Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269219AbRHGR3G>; Tue, 7 Aug 2001 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269212AbRHGR2t>; Tue, 7 Aug 2001 13:28:49 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40326 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269218AbRHGR2Z>; Tue, 7 Aug 2001 13:28:25 -0400
Date: Tue, 7 Aug 2001 11:28:28 -0600
Message-Id: <200108071728.f77HSSj05556@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <3B7024EE.D58E6BF@redhat.com>
In-Reply-To: <200108070517.f775HEw30547@vindaloo.ras.ucalgary.ca>
	<Pine.SOL.3.96.1010807111835.6737A-100000@draco.cus.cam.ac.uk>
	<200108071709.f77H9GD05198@vindaloo.ras.ucalgary.ca>
	<3B7024EE.D58E6BF@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
> Richard Gooch wrote:
>  
> > Finally, a spinlock is less code (0) and faster on UP.
> 
> Ehm not if you require protection against IRQ events......

Obviously. But I don't, in this case.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
