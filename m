Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132046AbQKWOTJ>; Thu, 23 Nov 2000 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132601AbQKWOS6>; Thu, 23 Nov 2000 09:18:58 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:47596 "EHLO mgw-x3.nokia.com")
        by vger.kernel.org with ESMTP id <S132046AbQKWOSw>;
        Thu, 23 Nov 2000 09:18:52 -0500
Message-ID: <3A1D203D.440632A2@trshp.ntc.nokia.com>
Date: Thu, 23 Nov 2000 15:48:45 +0200
From: Marko Kohtala <kohtala@trshp.ntc.nokia.com>
Organization: Nokia
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: fi,en
MIME-Version: 1.0
To: FyreMoon@fyremoon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: ixj compile problems in 2.4.0-test11
In-Reply-To: <E13ywQD-0007M1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a problem while compiling test11 on test9 kernel with debian
gcc-2.95.2. I had suspended the compilation with Ctrl-Z and it
continuted by compiling some garbage. Next time it compiled fine, so I'd
guess the files were ok in cache.

I do not know who is to blaim. Just thought to share this in case this
is the same problem.

Alan Cox wrote:
> > ixj.c: In function      xj_ioctl':
> > ixj.c:4703: D_PHONE_RING_START' undeclared (first use in this function)
> 
> You have some kind of corruption here
> 
> You might want to unpack and build the new kernel with a known good kernel
> rather than test9
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
