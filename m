Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281525AbRKMFo4>; Tue, 13 Nov 2001 00:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRKMFoq>; Tue, 13 Nov 2001 00:44:46 -0500
Received: from mail120.mail.bellsouth.net ([205.152.58.80]:31051 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281525AbRKMFof>; Tue, 13 Nov 2001 00:44:35 -0500
Message-ID: <3BF0B32F.EB6BD32D@mandrakesoft.com>
Date: Tue, 13 Nov 2001 00:44:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <200111130503.fAD53ns17951@vindaloo.ras.ucalgary.ca>
		<Pine.GSO.4.21.0111130019340.22925-100000@weyl.math.psu.edu> <200111130535.fAD5ZKa18694@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> In fact, given the other code in the tree that doesn't conform to
> CodingStyle, it makes sense run lindent on the whole tree and make
> that available. As long as people understand that they should generate
> patches against the real tree, and not the lindented one.

We are slowly Lindenting the -real- tree, actually.  So, no, that
doesn't make sense.  See my mention of long-term maintainability
earlier...

WRT to other code, devfs is indeed being picked on, because devfs
-clearly- needs other eyes, and devfs is so far from current
CodingStyle.

Readability of devfs is IMHO far more important than the readability of
drivers/scsi/random_isa_driver.c.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

