Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131474AbQKVVoG>; Wed, 22 Nov 2000 16:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131442AbQKVVnq>; Wed, 22 Nov 2000 16:43:46 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:40452 "EHLO
        mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
        id <S130671AbQKVVng>; Wed, 22 Nov 2000 16:43:36 -0500
Date: Wed, 22 Nov 2000 22:11:52 +0000
From: Heinz.Mauelshagen@t-online.de (Heinz J. Mauelshagen)
To: Brian Kress <kressb@fsc-usa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions for LVM
Message-ID: <20001122221152.B4406@srv.t-online.de>
Reply-To: Mauelshagen@Sistina.com
In-Reply-To: <3A1C3523.A111CDD9@fsc-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A1C3523.A111CDD9@fsc-usa.com>; from kressb@fsc-usa.com on Wed, Nov 22, 2000 at 04:05:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 04:05:39PM -0500, Brian Kress wrote:
> 	Question about /proc/partitions and LVM.  LVM devices in 
> /proc/partitions currently show up as lvma, lvmb, etc, depending on
> their device number.  This breaks things like mount by filesystem
> name.  Back when LVM existed as a patch, I believe there was some
> support in fs/partitions/check.c for showing the proper name for
> the device (something like <vgname>/<lvname>).  

Yes.
It actually was <vgname>/<lvname>.

Linus didn't accept it though.

The code is still available in case he changes his mind.

> 	Are their any plans for something like this to be added
> or is their a reason it was taken out?
> 
> 
> 	BTW, 2.4.0-test11 is the first "perfect" kernel for me.  It
> finally has everything I use working correctly.  (well, with a 
> small raid5 patch, anyway).
> 
> 
> Brian Kress
> kressb@fsc-usa.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 

Regards,
Heinz      -- The LVM guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Bartningstr. 12
                                                  64289 Darmstadt
                                                  Germany
Mauelshagen@Sistina.com                           +49 6151 7103 86
                                                       FAX 7103 96
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
