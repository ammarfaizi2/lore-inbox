Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129314AbQK1UIr>; Tue, 28 Nov 2000 15:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129391AbQK1UIh>; Tue, 28 Nov 2000 15:08:37 -0500
Received: from kootenai.mcn.net ([204.212.170.6]:6919 "EHLO kootenai.mcn.net")
        by vger.kernel.org with ESMTP id <S129314AbQK1UIY>;
        Tue, 28 Nov 2000 15:08:24 -0500
Message-ID: <3A2409C0.90CC03AC@mcn.net>
Date: Tue, 28 Nov 2000 12:38:40 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre2 -- Broken build.  Many definitions redefined
In-Reply-To: <3A23FC14.8020403@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> /usr/src/linux/include/linux/kernel_stat.h:48: for each function it
> appears in.)make[2]: *** [ksyms.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/kernel'
> make: *** [_dir_kernel] Error 2
> 

Oddly enough, I had to run 'make mrproper' on a clean tree (patched
from -test1 -> test12p2) in order to make it compile.

-- 
===============
-- Tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
