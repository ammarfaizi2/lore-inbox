Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRAKKGU>; Thu, 11 Jan 2001 05:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRAKKGK>; Thu, 11 Jan 2001 05:06:10 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:50439 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130017AbRAKKF7>; Thu, 11 Jan 2001 05:05:59 -0500
Message-ID: <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 11:05:55 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: andrea@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De> <200101110841.AAA01652@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Mind trying it with the "HAVE_FXSR" and "HAVE_XMM" macros in
> 
>         linux/include/asm-i386/processor.h
> 
> fixed? They _should_ be just
> 
>         #define HAVE_FXSR       (cpu_has_fxsr)
>         #define HAVE_XMM        (cpu_has_xmm)

That doesn't help either.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
