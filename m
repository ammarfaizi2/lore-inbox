Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUFXVM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUFXVM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUFXVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:12:18 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:53463 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265837AbUFXVJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:09:52 -0400
Date: Thu, 24 Jun 2004 17:09:47 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware
Message-ID: <20040624210947.GV728@washoe.rutgers.edu>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it is seems to be more general problem, because it slows down not only
dpkg process - booting on 2.4.26 kernel takes about 5 minutes to
complete and of cause no dpkg is involved in that process.

I took dpkg as just single example, I don't what to try else on...
bogomips reports about 50% of what is in /proc/cpuinfo, so it looks
normal... I'm suspecting IDE, so it looks like when app has to work with
HDD then it slows down although HDD bulb doesn't report an activity....
but I might be wrong. btw - I will put hdparm as well on the
webpage

We are about to setup X on that beast and I will try may be some other
programs... suggestions?

--
Yarik


On Thu, Jun 24, 2004 at 11:58:55PM +0300, Denis Vlasenko wrote:
> On Thursday 24 June 2004 23:26, Yaroslav Halchenko wrote:
> > please have a look at
> > http://www.onerussian.com/Linux/bugs/alien/topout

> > which has 4 runs of top in it


> > Also I put more relevant information in
> > http://www.onerussian.com/Linux/bugs/alien/

> > Spasibki Zaranee

>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND [K [0m
>  1501 root      25   0 25072  17M 13612 R    67.5  1.7   1:03 dpkg [K
>  1509 root      19   0  2060 1016  1852 R    25.8  0.0   0:00 top [K

> So, dpkg is misbehaving. Not a kernel problem.

> Do a

> # strace -p 1501

> and you'll se what's going on
-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

