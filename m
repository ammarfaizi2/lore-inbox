Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129648AbQKYTPT>; Sat, 25 Nov 2000 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129822AbQKYTPK>; Sat, 25 Nov 2000 14:15:10 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:51986 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S129648AbQKYTOz>; Sat, 25 Nov 2000 14:14:55 -0500
Date: Sat, 25 Nov 2000 19:44:49 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <E13zk0b-0001CU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001125194140.1936A-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > benn compiled into the kernel, and not as a module) always gave the
> > errors:
> > 
> > eth0: Transmit timed out: status 0050  0090 at 134704418/134704432 
> > eth0: Trying to restart the transmitter...
> 
> Known problem. This one might be fixed in current 2.2.18pre. SOme people
> see it some dont
Ok, we're on the way to try to avoid the use of that ethernet card anyway

> 
> > mistake... But we couldn't go back to oldier kernels (because of the Mylex
> > card) so the only possibility is to go forward: we compiled the
> > 2.4.0-test11 kernel. It could be usefull also because of the khttpd, at
> > least we could free up some memory used by the apache.
> 
> You can copy the 2.2.17 updated mylex driver into 2.2.14 and rebuild a kernel
> that way. In fact that would be a good test

Ok, I'll try. Since I'm not a kernel developer, I have the fool question,
wether it is enough to overwrite the .c and .h files in the 2.2.14 source
tree, or do I need to apply other changes too?


+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
