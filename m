Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRG1EDx>; Sat, 28 Jul 2001 00:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266339AbRG1EDm>; Sat, 28 Jul 2001 00:03:42 -0400
Received: from groucho.maths.monash.edu.au ([130.194.160.211]:45587 "EHLO
	groucho.maths.monash.edu.au") by vger.kernel.org with ESMTP
	id <S266251AbRG1ED3>; Sat, 28 Jul 2001 00:03:29 -0400
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200107280403.EAA11561@groucho.maths.monash.edu.au>
Subject: Re: 2.4.7 + VIA Pro266 + 2xUltraTx2 lockups
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jul 2001 14:03:18 +1000 (EST)
In-Reply-To: <E15Q4KV-0005LU-00@the-village.bc.nu> from "Alan Cox" at Jul 27, 2001 10:54:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Alan Cox wrote:
>Robin Humble wrote:
>> So the system is stable when driving a single Tx2 card, or on a BX,
>> but just not two Tx2's together on the pro266 board :-/ So it's
>> perhaps (I'm guessing here :) a non-trivial Tx2 driver bug or maybe a
>> VIA Pro266 problem?
>
>Firstly please try 2.4.6-ac5 as that has the proper VIA workaround for their
>bridge bugs. Its useful to rule out the very conservative approach the older
>kernels use to avoid the disk corruption problem they had

Ok. That locked up in the same way unfortunately :-/
Also a 2.4.8-pre1-xfs that I just tried...
I tried the "noapic" option as suggested in another email and that
didn't change anything either.

We've moved all the disks and controllers to a BX m/b machine for now, but
if there's anything else you want us to be guinea pigs for them we'll be
happy to try it out on the VIA Pro266 machine.
One other odd thing is that I have yet to make the CUV266 board see any
devices on its built-in secondary IDE controller. I have no idea why that
could be... The BIOS just doesn't detect them. Might that be a related
problem? Perhaps it's a faulty motherboard? Seems unlikely.

Please CC me on any replies as I'm not subscribed... ta...

cheers,
robin
