Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130162AbQKWA5K>; Wed, 22 Nov 2000 19:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130671AbQKWA5A>; Wed, 22 Nov 2000 19:57:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34574 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S130162AbQKWA4v>;
        Wed, 22 Nov 2000 19:56:51 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011230026.AAA02848@raistlin.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Thu, 23 Nov 2000 00:26:30 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011222354.eAMNs1564115@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 22, 2000 06:54:01 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> > Function entered at [<c2800060>] from [<c0026194>]
> > Function entered at [<c0025ac0>] from [<c0016860>]
> > Code: e51f2024 e5923000 (e5813000) e3a00000 e51f3030
> 
> All those numbers get looked up. Keep going for another 25 lines too.

Oh, missed this one.  Here you're wrong again.  The numbers in [< >]
should be looked up, and no others.  The code can look exactly like
a kernel address.  In this case you definitely do NOT want to have
them converted.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
