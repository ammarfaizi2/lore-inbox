Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbRG2Uvp>; Sun, 29 Jul 2001 16:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268151AbRG2Uvf>; Sun, 29 Jul 2001 16:51:35 -0400
Received: from mail.zmailer.org ([194.252.70.162]:58640 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S268150AbRG2Uvb>;
	Sun, 29 Jul 2001 16:51:31 -0400
Date: Sun, 29 Jul 2001 23:51:37 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Stanciu Adrian <adi@Aniela.EU.ORG>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem compiling some code
Message-ID: <20010729235137.C2650@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33.0107292254270.757-100000@ns1.Aniela.EU.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107292254270.757-100000@ns1.Aniela.EU.ORG>; from adi@Aniela.EU.ORG on Sun, Jul 29, 2001 at 10:56:54PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29, 2001 at 10:56:54PM +0300, Stanciu Adrian wrote:
> PROBLEM: #include errors

  This should be FAQ...

> Hello,
> 
> I'm trying to compile the following code:
> 
> // test.c begins here
>     #include <linux/modversions.h>
>     #include <linux/module.h>
>     #include <linux/version.h>
>     #include <linux/kernel.h>
>     #include <linux/pci.h>
>     #include <linux/delay.h>
>     #include <asm/uaccess.h>
> 
>     void main(void)
>     {
>         // no further code needed
>     }
> // end of test.c
> 
> But I get the following errors and warning messages:
....
> The program is compiled using: gcc -Wall test.c

  If you are compiling kernel modules (I presume you are),
  observing that kernel compiles everything with -D:s of:
	-D__KERNEL__
	-DMODULE
  depending of few things, usually also with:
	-DMODVERSIONS

  should give you a clue...

> 10x

/Matti Aarnio
