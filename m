Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbQKHDtS>; Tue, 7 Nov 2000 22:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbQKHDtI>; Tue, 7 Nov 2000 22:49:08 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:47542 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129544AbQKHDtA>; Tue, 7 Nov 2000 22:49:00 -0500
Date: Tue, 7 Nov 2000 21:48:59 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build
Message-ID: <Pine.LNX.4.21.0011072148270.10929-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Alan Cox wrote:

>Date: Tue, 7 Nov 2000 12:11:57 +0000 (GMT)
>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: Keith Owens <kaos@ocs.com.au>
>Cc: Tomasz Motylewski <motyl@stan.chemie.unibas.ch>,
>     Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and
>    /lib/modules/..../build
>
>> Agreed, I was unhappy that the build symlink was added to 2.2 kernels.
>> Now you need modutils >= 2.3.14 for 2.2 kernels :(.  But nobody asks
>> me, I'm just the kernel module.[ch] and modutils maintainer.
>
>Actually they do. I agree that it wants sorting. Im just wondering what the
>best approach is - maybe check modutils rev and only add the link if its high
>enough ?

What if build-machine != machine-kernel-was-built-for?


----------------------------------------------------------------------
   NOTE:  My new email address is:  mharris@opensourceadvocate.org

      Mike A. Harris  -  Linux advocate  -  Open source advocate
              Computer Consultant - Capslock Consulting
                 Copyright 2000 all rights reserved
----------------------------------------------------------------------

"Facts do not cease to exist because they are ignored."
                                               - Aldous Huxley


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
