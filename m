Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRHTVWX>; Mon, 20 Aug 2001 17:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHTVWN>; Mon, 20 Aug 2001 17:22:13 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:10402 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S268940AbRHTVWB>; Mon, 20 Aug 2001 17:22:01 -0400
Message-ID: <030501c129bd$f6705800$103147ab@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "Taylan Akdogan" <akdogan@mit.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108201649520.24485-100000@psi.mit.edu>
Subject: Re: Suspending a process into disk?
Date: Mon, 20 Aug 2001 14:20:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please check http://www.checkpointing.org.  There are several projects
listed there.

Current general kernel level checkpointing support is still limited (i.e.,
doesn't support all applications in all cases).  Two projects you may want
to check: epckpt (a kernel patch) and CRAK (a kernel module).

-Hua

----- Original Message -----
From: "Taylan Akdogan" <akdogan@mit.edu>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, August 20, 2001 2:04 PM
Subject: Suspending a process into disk?


> Hello All,
>
> I was wondering, if suspending a specific process into disk and
> resuming from the disk after a reboot is possible.  Let's assume
> that the process in question has a couple of open files for r/w,
> say on ext2, if it makes difference, and it isn't using any
> network connection.
>
> It could be very useful, if you have to reboot the system while
> your cpu-monster application is running for a long time...
> Sometimes, I have to delay a necessary (minor) kernel update
> because of week-long processes.
>
> Regards,
> Taylan
>
> ---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
> Taylan Akdogan              Massachusetts Institute of Technology
> akdogan@mit.edu                             Department of Physics
> ---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

