Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266365AbRGBEq3>; Mon, 2 Jul 2001 00:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266366AbRGBEqT>; Mon, 2 Jul 2001 00:46:19 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:46060 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266365AbRGBEqM>; Mon, 2 Jul 2001 00:46:12 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Jul 2001 21:46:04 -0700
Message-Id: <200107020446.VAA02397@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, rhw@MemAlpha.CX,
        rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>       Does anyone know if there is any code that would break if
>>>>we put quotation marks around the $CONFIG_xxxx references in the
>>>>dep_xxx commands in all of the Config.in files?

>>>That has the same problem that AC was worried about.  Variables that
>>>used to be treated as "undefined, don't care" are now treated as
>>>"undefined, assume n and forbid".

>>	What variables?  Please show me a real example.

>Not my job.  If you want to make a global change to the meaning of
>undefined config variables, it is your responsibility to show that the
>change has no unwanted side effects.  Assuming there are no side
>effects is unsatisfactory in a stable kernel, especially with all the
>config variables in patch sets outside the kernel.

	That's not reasonable in the face of what appears to be
completely fabricated myth.  You generally can't prove this
kind of a negative for anything.  Either you or Alan Cox should
show an example.  Can you even show me the code that such an
example would exercise.  Can you even write a hypothetical example?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
