Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbQKFJLs>; Mon, 6 Nov 2000 04:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbQKFJLh>; Mon, 6 Nov 2000 04:11:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5386 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129036AbQKFJLX>;
	Mon, 6 Nov 2000 04:11:23 -0500
Message-ID: <3A067597.FE669D4F@mandrakesoft.com>
Date: Mon, 06 Nov 2000 04:10:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <200011041941.WAA28119@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> > de4x5 is becoming EISA-only in 2.5.x too, since its PCI support is
> > duplicated now in tulip driver.
> 
> Luckily, my old Multia died. 8)
> 
> Jeff, tulip did not work with genuine Digital cards.

I'm pretty sure I fixed that.  Tested it on my Multia in fact :)  (and
my AS200 too)

The fix should be in 2.2.17 tulip.c, as well as 2.4.x...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
