Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbQKHADP>; Tue, 7 Nov 2000 19:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129940AbQKHADG>; Tue, 7 Nov 2000 19:03:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20234 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129975AbQKHACw>;
	Tue, 7 Nov 2000 19:02:52 -0500
Message-ID: <3A089752.505816BA@mandrakesoft.com>
Date: Tue, 07 Nov 2000 18:59:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sven Koch <haegar@cut.de>
CC: David Lang <david.lang@digitalinsight.com>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>, kernel@kvack.org,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.30.0011080047260.10874-100000@space.comunit.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Koch wrote:
> 
> On Tue, 7 Nov 2000, David Lang wrote:
> 
> > depending on what CPU you have the kernel (and compiler) can use different
> > commands/opmizations/etc, if you want to do this on boot you have two
> > options.
> 
> Wouldn't it be possible to compile the parts of the kernel needed to
> uncompress and to detect the cpu with lower optimizations and then abort
> with an error message?
> 
> "Error: Kernel needs a PIII" sounds much better than just stoping dead.

I agree...   maybe we can solve this simply by giving the CPU detection
module the -march=i386 flag hardcoded, or editing the bootstrap, or
something like that...

	Jeff



-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
