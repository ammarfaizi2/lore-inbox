Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315687AbSECTiX>; Fri, 3 May 2002 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315688AbSECTiW>; Fri, 3 May 2002 15:38:22 -0400
Received: from [195.163.186.27] ([195.163.186.27]:27295 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S315687AbSECTiV>;
	Fri, 3 May 2002 15:38:21 -0400
Date: Fri, 3 May 2002 22:38:18 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503223818.C1284@mea-ext.zmailer.org>
In-Reply-To: <20020503183701.32163.qmail@web13505.mail.yahoo.com> <Pine.LNX.3.95.1020503144728.8291A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 03:01:48PM -0400, Richard B. Johnson wrote:
...
> > This hasn't been an absolute requirement. There have
> > been 32-bit Unix implementations that gave separate
> > 4G address spaces to the kernel and to each user
> > process.  The only real downside to this is that
> > copyin()/copyout() are more complex. Some processors
> > provided special instructions to access user-mode
> > addresses from kernel to mitigate this complexity.
> > 
> > -Tony
> 
> Really? The only 32-bit Unix's I've seen the details of
> are SCO Unix, Interactive Unix, Linux, and BSD Unix.

   An example of hardware with fully separable user/kernel spaces
   are Motorola 68020-68060 series processors.

   They have those special instructions to choose (in kernel mode)
   what address spaces to use at which data access phase of the
   special moves.  There is some speed penalty, of course..

...
> Would you please tell me what Unix has 32-bit address space
> which is not shared with the kernel?

   That could be the one called "Linux", if a bunch of conditions
   are met -- beginning with suitable hardware.

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

/Matti Aarnio
