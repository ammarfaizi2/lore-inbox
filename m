Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135633AbRDXOI6>; Tue, 24 Apr 2001 10:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135634AbRDXOIt>; Tue, 24 Apr 2001 10:08:49 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:59562
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S135633AbRDXOIa>; Tue, 24 Apr 2001 10:08:30 -0400
Message-ID: <3AE588E9.2E1B1B5D@math.ethz.ch>
Date: Tue, 24 Apr 2001 16:08:41 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.75C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mirabilos <eccesys@topmail.de>, "Giacomo A. Catenazzi" <cate@dplanet.ch>,
        CML2 <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
In-Reply-To: <E14s3EC-00025p-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Well, would it be possible to create some module under LGPL, and then
> > have included it into the kernel? Maybe it needs to maintain the LGPL
> > version out of the kernel, and transform a copy to the GPL before
> > submitting?
> 
> There is kernel code under a whole variety of licenses. When linked together
> the resulting work is GPL but many of the pieces used on their own or in
> conjunction with different code are not GPL.

Unfortunatelly there are exeptions:
the old ppp driver (only lickable to GPL kernel).
and drivers/usb/serial/keyspan_usa18x_fw.h:
1 /* keyspan_usa18x_fw.h
2   
3    Generated from Keyspan firmware image Wed Jul  5 09:18:29
2000 EST
4    This firmware is for the Keyspan USA-18X Serial Adaptor
5 
6    "The firmware contained herein as keyspan_usa18x_fw.h is
7    Copyright (C) 1999-2000 Keyspan, A division of InnoSys
Incorporated
8    ("Keyspan"), as an unpublished work.  This notice does
not imply
9    unrestricted or public access to this firmware which is a
trade secret of
10    Keyspan, and which may not be reproduced, used, sold or
transferred to any
11    third party without Keyspan's prior written consent. 
All Rights Reserved.
12 
13    This firmware may not be modified and may only be used
with the Keyspan 
14    USA-18X Serial Adapter.  Distribution and/or
Modification of the
15    keyspan.c driver which includes this firmware, in whole
or in part,
16    requires the inclusion of this statement."
17 
18 */
with a surelly non-free/non-GPL license.

Maybe we should, as in tetex, check every license in every
file, to remove
the non-free files.
[But anyone (not-M$) will sue us?]

	giacomo
