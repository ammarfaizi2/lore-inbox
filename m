Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265962AbRGERXg>; Thu, 5 Jul 2001 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265964AbRGERX0>; Thu, 5 Jul 2001 13:23:26 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:21009 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S265962AbRGERXI>; Thu, 5 Jul 2001 13:23:08 -0400
Message-ID: <3B44A240.3510F24F@netpathway.com>
Date: Thu, 05 Jul 2001 12:22:08 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <036e01c1056a$665b0d40$6cc8c58f@satoy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm,

I have no problems either.

Asus KT7 KT133 Chipset

root@station2-lnx:~# uname -a
Linux station2-lnx 2.4.6 #10 Thu Jul 5 11:08:39 CDT 2001 i686 unknown
root@station2-lnx:~# free
             total       used       free     shared    buffers     cached
Mem:        512944     509888       3056          0      32140     417532
-/+ buffers/cache:      60216     452728
Swap:      1100444          0    1100444

> 
> > Can someone please
> > point out to me
> > that he's actually running kernel-2.4.x on a machine with
> > more than 128
> > MB RAM and that he's NOT having severe stability problems?
> > And can that same person PLEASE point out to me why 2.4.x is
> > crashing on
> > me (or help me to find out...)?
> 
> %uname -a
> Linux cartman 2.4.0-64GB-SMP #1 SMP Wed Jan 24 15:52:30 GMT 2001 i686
> unknown
> %uptime
>  8:35am  up 57 days, 12:42,  2 users,  load average: 2.00, 2.00, 2.00
> %free
>              total      used      free      shared      buffers      cached
> Mem:        254904    251968      2936           0        92224       45028
> -/+ buffers/cache:    114716    140188
> Swap:       524656     14192    510464
> 
> Could this be a 2.4 swap issue. You NEED at least RAM x2 swap. If you're
> just adding memory to
> a box that's stable with 128 megs and possibly 256 megs swap (you don't
> state, just guessing..)
> you've now got too little swap, and boom, stability goes bye-bye.
> 
> Just haven't seen the swap issue mentioned this thread...
> 
> =Don=
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314

