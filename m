Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282183AbRKWQiO>; Fri, 23 Nov 2001 11:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282186AbRKWQiH>; Fri, 23 Nov 2001 11:38:07 -0500
Received: from Expansa.sns.it ([192.167.206.189]:57860 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S282183AbRKWQhy>;
	Fri, 23 Nov 2001 11:37:54 -0500
Date: Fri, 23 Nov 2001 17:37:48 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Norm Dressler <ndressler@dinmar.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Sparc64 Compiles OK, but won't boot new kernel
In-Reply-To: <002101c17430$d94b2f80$3828a8c0@ndrlaptop>
Message-ID: <Pine.LNX.4.33.0111231736510.998-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You did not enable LVM support, did you?
if you did enable, with 2.4.15, yyopu will see the bug i wrote about.

I had similar problems like you, I simply compiled as a module all I
could, and I solved.


On Fri, 23 Nov 2001, Norm Dressler wrote:

> Hi,
>
> I have been able to successfully compile the 2.4.14 and 2.4.15 kernels
> for Sparc64 but each gives me an error on boot-up:
>
> Image to large for Destination  (twice)
>
> It then kicks me back to the silo prompt.  My kernel is trimmed back
> quite a bit and there isn't a lot there.
>
> It's not a compressed kernel -- should it be?  How do I do that since
> the bzImage make is missing from the Sparc64 makefiles?
>
> I am using Redhat 6.2 on an Enterprise 4000, 4 Ultrasparc-II CPU's and
> 2Gb of Ram.
>
> Any suggestions??
>
> Norm
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

