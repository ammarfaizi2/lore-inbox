Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289455AbSBNCbs>; Wed, 13 Feb 2002 21:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289487AbSBNCbk>; Wed, 13 Feb 2002 21:31:40 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:56588 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289455AbSBNCb2>; Wed, 13 Feb 2002 21:31:28 -0500
Subject: (Here's the right .config info) Re: 2.5.5-pre1 -- rd.c:271: In
	function `rd_make_request': too many arguments to function
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1013653000.1574.4.camel@turbulence.megapathdsl.net>
In-Reply-To: <1013653000.1574.4.camel@turbulence.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 13 Feb 2002 18:28:01 -0800
Message-Id: <1013653682.1574.7.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included the wrong .config chunk.  Here is the correct one.

On Wed, 2002-02-13 at 18:16, Miles Lane wrote:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon   
> -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
> rd.c: In function `rd_make_request':
> rd.c:271: too many arguments to function
> make[3]: *** [rd.o] Error 1

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y



