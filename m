Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132527AbQKWDfM>; Wed, 22 Nov 2000 22:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132531AbQKWDfC>; Wed, 22 Nov 2000 22:35:02 -0500
Received: from 133-VALL-X8.libre.retevision.es ([62.83.212.133]:59776 "EHLO
        looping.es") by vger.kernel.org with ESMTP id <S132527AbQKWDer>;
        Wed, 22 Nov 2000 22:34:47 -0500
Date: Thu, 23 Nov 2000 04:11:49 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: silly [< >] and other excess
Message-ID: <20001123041149.A17763@macula.net>
In-Reply-To: <200011222354.eAMNs1564115@saturn.cs.uml.edu> <200011230026.AAA02848@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <200011230026.AAA02848@raistlin.arm.linux.org.uk>; from Russell King on Thu, Nov 23, 2000 at 12:26:30AM +0000
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 12:26:30AM +0000, Russell King wrote:
> Albert D. Cahalan writes:
> > > Function entered at [<c2800060>] from [<c0026194>]
> > > Function entered at [<c0025ac0>] from [<c0016860>]
> > > Code: e51f2024 e5923000 (e5813000) e3a00000 e51f3030
> > 
> > All those numbers get looked up. Keep going for another 25 lines too.
> 
> Oh, missed this one.  Here you're wrong again.  The numbers in [< >]
> should be looked up, and no others.  The code can look exactly like
> a kernel address.  In this case you definitely do NOT want to have
> them converted.

Okay.  How about just using some prefix to the hex number, such as '>'?
It'll still save plenty of space, and would be trivial changes for the
tools.  

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
