Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRHOO3j>; Wed, 15 Aug 2001 10:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269524AbRHOO33>; Wed, 15 Aug 2001 10:29:29 -0400
Received: from N23ch-01p18.ppp11.odn.ad.jp ([61.116.127.18]:45807 "HELO
	220fx.luky.org") by vger.kernel.org with SMTP id <S269041AbRHOO3U>;
	Wed, 15 Aug 2001 10:29:20 -0400
To: axboe@suse.de
Cc: joseph@5sigma.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 4.7GB DVD-RAM geometry wrong?
In-Reply-To: <20010815131733.I545@suse.de>
In-Reply-To: <20010815111030Z271139-761+1405@vger.kernel.org>
	<20010815131733.I545@suse.de>
X-Face: (p:N+d=)]R.hGpO.WD'FWD}r"'N]'G~TQL>ZMHN6Ev":krdN|{+={]m/yqX7|9Qzu[eX[+}
 ^=d9Vr7#OCKV?ZAYq=#iG2v&fyuJZWeVwGrmTRvpcWiSTzga-$8/W\XR"r]63S56VQ@[8w}/;iq)sm
 1=B_r2J$Uf~aN5@8f2Fk$Oa[wZ
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010815233424P.shibata@luky.org>
Date: Wed, 15 Aug 2001 23:34:24 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have a Panasonic DVD-RAM, LF-D201 (SCSI 4.7/9.4GB).  I put in a
> > 4.7GB type II cartridge (that's a single-sided disk), did 'mkfs 
> > /dev/scd0' and then mounted it, and ... I have a 2.2GB disk!

Almost the same problem here w/ 5.2GB HITACHI DVD-RAM Drive, GF-2050.

> Attached patch should fix it, Linus please apply.

The patch with 2.4.8-ac5 fixed my problem.

Thanks

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata @ Fukuoka, JAPAN
0(mmm)0 IRC: #luky
   ~    http://his.luky.org/ http://hoop.euqset.org/
