Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRJJQIA>; Wed, 10 Oct 2001 12:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277299AbRJJQH6>; Wed, 10 Oct 2001 12:07:58 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:30272 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277296AbRJJQHm>; Wed, 10 Oct 2001 12:07:42 -0400
Date: Wed, 10 Oct 2001 11:08:01 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Luis Montgomery <monty@fismat1.fcfm.buap.mx>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11: problem with at1700
In-Reply-To: <Pine.GSO.4.21.0110100409260.27961-100000@fismat1.fcfm.buap.mx>
Message-ID: <Pine.LNX.3.96.1011010110710.24939B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, Luis Montgomery wrote:

> 
> I try to compile 2.4.11 and find this error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
> -include /usr/src/linux-2.4.11/include/linux/modversions.h   -c -o
> at1700.o at1700.c
> at1700.c:475: conflicting types for `read_eeprom'
> at1700.c:161: previous declaration of `read_eeprom'
> make[2]: *** [at1700.o] Error 1

I sent an incomplete patch to Linus; just back out the patch for wait
for a fix to appear in 2.4.12-pre1...

	Jeff




