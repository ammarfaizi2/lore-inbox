Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEK5D>; Fri, 5 Jan 2001 05:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAEK4y>; Fri, 5 Jan 2001 05:56:54 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:52661 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129267AbRAEK4m>; Fri, 5 Jan 2001 05:56:42 -0500
Date: Fri, 5 Jan 2001 05:57:38 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Pete Zaitcev <zaitcev@metabyte.com>, <linux-kernel@vger.kernel.org>
Subject: Re: So, what about kwhich on RH6.2?
In-Reply-To: <200101042212.f04MCDN510138@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.31.0101050556350.27543-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Albert D. Cahalan wrote:

>>>> can't we just hardwire `kgcc' into the build system and be done
>>>> with all this kwhich stuff?  It's just a symlink....
>>>
>>> And break compilation on all non RedHat 7, non connectiva systems ?
>>> Would you volunteer to handle the support load on l-k that would cause?
>>
>> Hardcoding kgcc is definitely not an option.
>
>Creating symlinks during the build would solve the problem.
>
>/usr/src/linux/kern-cc -> /usr/bin/kgcc
>/usr/src/linux/user-cc -> /usr/bin/gcc

But who builds kernels in /usr/src anymore, or as root for that
matter...   ;o)


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

If at first you don't succeed, call it version 1.0

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
