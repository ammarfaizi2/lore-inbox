Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131884AbQKYXdm>; Sat, 25 Nov 2000 18:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131954AbQKYXdc>; Sat, 25 Nov 2000 18:33:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35340 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S131884AbQKYXdN>;
        Sat, 25 Nov 2000 18:33:13 -0500
Message-ID: <3A20451B.2A69BB75@mandrakesoft.com>
Date: Sat, 25 Nov 2000 18:02:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <aeb@veritas.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> In a program source there is information for the compiler
> and information for the future me. Removing the " = 0"
> is like removing comments. For the compiler the information
> remains the same. For the programmer something is lost.

This is pretty much personal opinion :)

The C language is full of implicit as well as explicit features.  You
are arguing that using an implicit feature robs the programmer of
information.  For you maybe...  For others, no information is lost AND
the code is more clean AND the kernel is smaller.  It's just a matter of
knowing and internalizing "the rules" in your head.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
