Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRJADtV>; Sun, 30 Sep 2001 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274522AbRJADtM>; Sun, 30 Sep 2001 23:49:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2300
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274520AbRJADtA>; Sun, 30 Sep 2001 23:49:00 -0400
Date: Sun, 30 Sep 2001 20:49:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: md5sum: WARNING: 4 of 13 computed checksums did NOT match
Message-ID: <20010930204922.B25387@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1001907794.19740.1.camel@DESK-2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001907794.19740.1.camel@DESK-2>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 11:43:10PM -0400, Jeffrey Ingber wrote:
> Hi,
> 
> 	I receive this warning when compiling 2.4.10.  Maybe it's not
> important, but it caught my attention.
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.10/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.10/include/linux/modversions.h   -c -o c4.o c4.c
> make[3]: Leaving directory `/usr/src/linux-2.4.10/drivers/isdn/avmb1'
> make -C hisax modules
> md5sum: WARNING: 4 of 13 computed checksums did NOT match
> 
> Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)
> 

I've even seen this on 2.2.19.  I don't know why it hasn't been fixed, but it's
been there for a while...
