Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132501AbQLNF2T>; Thu, 14 Dec 2000 00:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbQLNF2K>; Thu, 14 Dec 2000 00:28:10 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:20242 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131921AbQLNF1z>; Thu, 14 Dec 2000 00:27:55 -0500
Message-Id: <200012140457.eBE4vNs43248@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: shirsch@adelphia.net, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Wed, 13 Dec 2000 20:22:48 PST."
             <200012140422.UAA10340@pizda.ninka.net> 
Date: Wed, 13 Dec 2000 21:57:23 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Date: 	Wed, 13 Dec 2000 20:56:08 -0700
>   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>
>   None-the-less, it seems to me that spamming the kernel namespace
>   with "current" in at least the way that the 2.2 kernels do (does
>   this occur in later kernels?) should be corrected.
>
>Justin, "current" is a pointer to the current thread executing on the
>current processor under Linux.  It has existed since day one of the
>Linux kernel and probably will exist till the end of it's life.
>
>I'm sure the BSD kernel has some similar bogosity :-)

BSD has curproc, but that is considerably less likely to be
used in "inoccent code" than "current".  I mean, "current what?".
It could be anything, current privledges, current process, current
thread, the current time...

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
