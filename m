Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSEYHvw>; Sat, 25 May 2002 03:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEYHvv>; Sat, 25 May 2002 03:51:51 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:40463 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S314077AbSEYHvu>; Sat, 25 May 2002 03:51:50 -0400
Message-ID: <3CEF423D.7030901@megapathdsl.net>
Date: Sat, 25 May 2002 00:50:21 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18 -- build failure -- suspend.c:1052: dereferencing pointer
 to incomplete type	
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim wrote:
 > On Fri, 24 May 2002, Miles Lane wrote:
 >
 > > I have included the error, the output of ver_linux and
 > > snippets of .config.
 >
 > I have not yet analyzed why I don't get this failunre, but does the
 > following patch fix it for you?

Nope.  The builds still fails with the same errors.
I will send you my entire .config file in private mail,
since the list likely doesn't want to see the whole thing.

Thanks,
	Miles

 > Tim
 >
 > --- linux-2.5.18/kernel/suspend.c       Sat May 25 09:25:30 2002
 > +++ linux-2.5.18/kernel/suspend.c       Sat May 25 09:25:44 2002
 > @@ -66,6 +66,7 @@
 >  #include <linux/swap.h>
 >  #include <linux/pm.h>
 >  #include <linux/device.h>
 > +#include <linux/sched.h>
 >  
 >  #include <asm/uaccess.h>
 >  #include <asm/mmu_context.h>


