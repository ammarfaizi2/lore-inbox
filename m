Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSK0Aqd>; Tue, 26 Nov 2002 19:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSK0Aqd>; Tue, 26 Nov 2002 19:46:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35021 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262303AbSK0Aqc>; Tue, 26 Nov 2002 19:46:32 -0500
Date: Wed, 27 Nov 2002 01:53:48 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <20021127005348.GJ21307@fs.tum.de>
References: <20021126231507.GF21307@fs.tum.de> <Pine.LNX.4.33L2.0211261547450.2873-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211261547450.2873-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 03:49:11PM -0800, Randy.Dunlap wrote:
> On Wed, 27 Nov 2002, Adrian Bunk wrote:
>...
> | -       return err;
> | +       return err ? : len;
>...
> Hi Adrian,
> 
> That's a gcc extension that means the same as your patch.  See
> http://gcc.gnu.org/onlinedocs/gcc-3.2/gcc/Conditionals.html#Conditionals
>...

Ah, thanks for the correction. I didn't know that there is such a gcc
extension.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

