Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRCGSjR>; Wed, 7 Mar 2001 13:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbRCGSjI>; Wed, 7 Mar 2001 13:39:08 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:50848 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131152AbRCGSiu>; Wed, 7 Mar 2001 13:38:50 -0500
Message-Id: <5.0.2.1.2.20010307183606.00ac0b20@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 07 Mar 2001 18:38:53 +0000
To: Sourav Sen <sourav@csa.iisc.ernet.in>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.2-ac
Cc: kernelnewbies@humbolt.nl.linux.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.3.96.1010307234516.22645A-100000@kohinoor.csa.iis
 c.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The image path should go to /wherever/bzImage not /wherever/vmlinux![1]

I assume this is what is wrong.

Regards,

Anton

[1] FYI: it is found in /usr/src/linux/arch/i386/boot/bzImage on ia32 
architecture assuming your kernel is in /usr/src/linux.

At 18:26 07/03/2001, Sourav Sen wrote:

>Hi,
>         I have patched 2.4.2 with patch-2.4.2-ac9. At make xconfig turned
>all kernel hacking options on. Then make dep and make bzImage went on ok.
>But when I put the image path in lilo.conf and ran /sbin/lilo it said
>kernel /abc/pqr/..../vmlinux is too big.
>
>         Whats going wrong. My gcc is egcs-2.91.66. The running kernel is
>2.2.14-5.0.
>
>thanks
>sourav
>--------------------------------------------------------------------------------
>SOURAV SEN    MSc(Engg.) CSA IISc BANGALORE URL : 
>www2.csa.iisc.ernet.in/~sourav
>ROOM NO : N-78      TEL :(080)309-2454(HOSTEL)          (080)309-2906 
>(COMP LAB)
>--------------------------------------------------------------------------------
>"the fault, dear Brutas, lies not in our stars, but in our memory systems"
>                                                                 -Shakespeare
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

