Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTAZOcS>; Sun, 26 Jan 2003 09:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbTAZOcS>; Sun, 26 Jan 2003 09:32:18 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:47532 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266932AbTAZOcR>;
	Sun, 26 Jan 2003 09:32:17 -0500
Date: Sun, 26 Jan 2003 15:41:33 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301261441.PAA08646@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, rekearney@adelphia.net
Subject: Re: Problems moving to 2.4.x from 2.2.x kernel  (unable to handle kernel paging request)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003 19:53:15 -0500, Robert E. Kearney Jr. wrote:
>I'v been running fine for quite a while now, and figured its time to
>update my kernel, and some of the software. I downloaded 2.4.20,
>configured according to my previous kernel build on 2.2.16, compiled and
>installed.  However, after about 1 min, I get a kernel panic(unable to
>handle kernel paging request at virtual addres ....), usually kswapd,
>sometimes machine dies right away, other times.. It dies a few seconds
>later.  
...
>Jan 23 22:18:09 terminus kernel: Linux version 2.4.20
>(root@terminus.dnspenguin.com) (gcc version 2.96 20000731 (Red Hat Linux
>7.0)) #4 Thu Jan 23 21:15:07 EST 2003

2.4 built with a very old gcc-2.96. Early 2.96 versions are known
to have problems. Please recompile with gcc 2.95.3 or 3.2 or RedHat's
latest gcc-2.96 update.

If the problems persist, run memtest86 for a couple of hours.

/Mikael
