Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbQKASJL>; Wed, 1 Nov 2000 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130737AbQKASJB>; Wed, 1 Nov 2000 13:09:01 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:9736 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130733AbQKASIt>;
	Wed, 1 Nov 2000 13:08:49 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011011808.VAA07484@ms2.inr.ac.ru>
Subject: Re: Linux-2.4.0-test10
To: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.DE (Andi Kleen)
Date: Wed, 1 Nov 2000 21:08:11 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001101093839.A16274@gruyere.muc.suse.de> from "Andi Kleen" at Nov 1, 0 11:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> On Tue, Oct 31, 2000 at 08:55:13PM +0000, Alan Cox wrote:
> > 	What about the fact anyone can crash a box using ioctls on net
> > 	devices and waiting for an unload - was this fixed ?

What do you mean?

If I understood you correclty, this has been fixed in early 2.3
and never reappeared since that time.



> The ioctls of network devices are generally unsafe on SMP, because
> they run with kernel lock dropped now but are mostly not safe to do so. 

Andi, pleeeease, stop FUDing.

If you see some bug, fix it. I do not see.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
