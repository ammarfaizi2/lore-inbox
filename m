Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281158AbRK3XL7>; Fri, 30 Nov 2001 18:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRK3XLt>; Fri, 30 Nov 2001 18:11:49 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:56251 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281158AbRK3XLd>; Fri, 30 Nov 2001 18:11:33 -0500
Date: Fri, 30 Nov 2001 16:11:22 -0700
Message-Id: <200111302311.fAUNBMs20243@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan and Vivian Vaughn <avvaughn@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Reply-To: devfs@oss.sgi.com
Subject: Re: devfsd 1.3.20 compile error
In-Reply-To: <5.1.0.14.0.20011130133941.009ed560@postoffice.pacbell.net>
In-Reply-To: <5.1.0.14.0.20011130133941.009ed560@postoffice.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan and Vivian Vaughn writes:
> I got the following error message when compiling devfsd 1.3.20
> 
> cc -O2 -I. -Wall   -DLIBNSL="\"/lib/libnsl.so.1\""   -c -o devfsd.o devfsd.c
> devfsd.c:480: `DEVFSD_NOTIFY_DELETE' undeclared here (not in a function)
> devfsd.c:480: initializer element is not constant
> devfsd.c:480: (near initialization for `event_types[7].type')
> make: *** [devfsd.o] Error 1

Actually, this is the wrong list for such bug reports, hence I've set
Reply-to: devfs@oss.sgi.com

To answer your question: you need modern kernel headers. Something
later than August (2.4 series) should be fine. Either unpack a new
kernel under /usr/src/linux or point the KERNEL_DIR environment
variable to where you've unpacked the new kernel.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
