Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTLXAxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 19:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTLXAxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 19:53:53 -0500
Received: from YahooBB219197212132.bbtec.net ([219.197.212.132]:17536 "EHLO
	rai.sytes.net") by vger.kernel.org with ESMTP id S262784AbTLXAxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 19:53:51 -0500
Message-ID: <3FE8E39D.4090905@yahoo.co.jp>
Date: Wed, 24 Dec 2003 09:53:49 +0900
From: Tetsuji Rai <badtrans666@yahoo.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, ja, zh-tw, zh-cn, zh-hk
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Solution found: kernel-2.6.0/esd/realplayer8 doesn't work
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Self reply and post as my reminder....
use

export LD_ASSUME_KERNEL=2.2.5

and realplayer works fine.

-------- Original Message --------
Subject: kernel-2.6.0/esd/realplayer8 doesn't work
Date: Tue, 23 Dec 2003 23:21:13 +0900
From: Tetsuji Rai <badtrans666@yahoo.co.jp>
To: linux-kernel@vger.kernel.org

Hi, all

   I just installed kernel-2.6.0 release on debian-testing.   On my box esd
works with xmms, mpg123 as with kernel-2.4.xx series, however, only
Realplayer8 cannot use esd at all.  Realplayer says "cannot open audio
device, Another application may be using it."  Sounds strange.   It works
very fine with the very same configuration on kernel 2.4.23.
   As a matter of course module-init-tools are installed for kernel-2.6.0.
Strange thing is xmms, mpg123 works, but that realplayer doesn't work.  And
when some weeks ago I tested kernel 2.6.0-test6/7, realplayer worked as
expected.
  Will anybody have any idea?   I once suspect it should be related to
connection between realplayer and esd, but if so kernel version doesn't
matter.   So there should be another reason;for eg. esound doesn't keep up
with kernel development...just a guess.

PS: I recompiled esound daemon 0.2.32 with kernel 2.6.0 for sure.

TIA
-- 
Tetsuji Rai (in Tokyo) aka AF-One (Athlete's Foot-One)
Born to be the luckiest guy in the world!   May the Force be with me!
http://www.geocities.com/tetsuji_rai
http://setiathome.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=view_feedback&id=1855
fax: 1-516-706-0320


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-- 
Tetsuji Rai (in Tokyo) aka AF-One (Athlete's Foot-One)
Born to be the luckiest guy in the world!   May the Force be with me!
http://www.geocities.com/tetsuji_rai
http://setiathome.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=view_feedback&id=1855
fax: 1-516-706-0320

