Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271840AbRHUTmn>; Tue, 21 Aug 2001 15:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271839AbRHUTmd>; Tue, 21 Aug 2001 15:42:33 -0400
Received: from smtp1.libero.it ([193.70.192.51]:64651 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S271840AbRHUTmV>;
	Tue, 21 Aug 2001 15:42:21 -0400
Message-ID: <3B82B988.50DE308A@iname.com>
Date: Tue, 21 Aug 2001 21:42:00 +0200
From: Luca Montecchiani <m.luca@iname.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [FAQ?] More ram=less performance (maximum cacheable RAM)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently updated my K6-2 from 128 to 256mbytes (2x128 pc133 dimms)
compiling kernel take now 13 minutes instead of 9 minutes :(

Ram is so cheap and socket7 is far from the death, time for a FAQ?

Here some description from http://9-muses.com/freak/reviews/super7.shtml :
The Level2 Cache determines the board's maximum cacheable RAM. 
Boards equipped with 512k can cache up to 128MB of RAM while
those equipped with 1MB can handle up to 256MB of RAM. If you're using all
of the RAM cacheable by the the L2 cache, performance is enhanced. Once you
go above the maximum cacheable RAM, performance is lost. What this means to
you is the more cache the better. For some users, 64MB or even 128MB of RAM
is enough, but who knows, somewhere down the road, you might want to upgrade
to 256MB. It's nice to know your board can handle the extra memory without
worrying about losing performance.

More technical information can be found here :
http://www.pcguide.com/ref/mbsys/cache/char_Cacheability.htm

Patch and other info about non cacheable ram here :
http://www.keryan.org/brad/slram/

ciao,
luca
-- 
------------------------------------------------------------------
E-mail......: Luca Montecchiani <m.luca@iname.com>
W.W.W.......: http://i.am/m.luca - http://luca.myip.org
Speakfreely.: sflwl -hlwl.fourmilab.ch luca@
I.C.Q.......: 17655604
-----------------------=(Linux since 1995)=-----------------------

Non esiste vento favorevole per il marinaio che non sa dove andare
                                                          Seneca
