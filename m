Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYLeQ>; Sat, 25 Nov 2000 06:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYLeH>; Sat, 25 Nov 2000 06:34:07 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:21766 "EHLO
        ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
        id <S129153AbQKYLdy>; Sat, 25 Nov 2000 06:33:54 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Raymond Nijssen <raymond.nijssen@Magma-DA.COM>
cc: linux-kernel@vger.kernel.org
Message-ID: <CA2569A2.003CC0C4.00@d73mta05.au.ibm.com>
Date: Sun, 26 Nov 2000 16:23:01 +0530
Subject: Re: max memory limits ???
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Matti Aarnio <matti.aarnio@zmailer.org> wrote:
>On Wed, Nov 22, 2000 at 03:37:09PM +0200, BenHanokh Gabriel wrote:

>> can some1 explain the memory limits on the 2.4 kernel

>> - what is the limit for user-space apps ?

>        At 32 bit systems:  3.5 GB with extreme tricks, 3 GB for more
usual.
user space apps will get killed by OOM if its memory required exceeds the
available physical memory+total swapping space.

Regards
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
