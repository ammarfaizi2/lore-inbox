Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRHUD2M>; Mon, 20 Aug 2001 23:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbRHUD2C>; Mon, 20 Aug 2001 23:28:02 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:28825 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268702AbRHUD1s>; Mon, 20 Aug 2001 23:27:48 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 20 Aug 2001 20:28:01 -0700
Message-Id: <200108210328.UAA24776@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: aic7xxx driver that does not need db library?
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  = Adam Richter
>   = Keith Owens

>>	Currently, building Justin Gibbs's otherwise excellent
>>aic7xxx driver requires the Berkeley DB library, because the
>>aic7xxx assembler that is used in the build process uses db
>>basically just to implement associative arrays in memory.
>>
>>	Unfortunately, I'm currently wrestling with db version
>>problems because gnome evolution requires the GPL'ed Sleepycat db 3.x,
>>so I want to keep db-1.85 around also, and this breaks the aicasm
>>build.

>(A) Do not check "build aic7xxx firmware".

	I want to build everything from source and I believe that is
important to other people as well.


>(B) kbuild 2.5 only selects the db*.h file that matches the current db
>    library, instead of assuming that the first db*.h that it can find
>    should be used.

	On one hand, I still prefer my solution of not needing db
at all to build the aic7xxx firmware.  I believe that compatability
problems in my db configuration is a system administration bug in the
one of the db packages or both, but I haven't fully disected it yet.

	On the other hand, what you describe sounds like an
improvement over what is in the stock kernel.  So, even though I'm not
inclined to jump to it right now, I appreciate your telling me about
it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
