Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTGDRWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTGDRVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:21:30 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:17418 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S265346AbTGDRVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:21:08 -0400
Message-ID: <002b01c34253$1602b1e0$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: "Matthias Andree" <matthias.andree@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
References: <4R5X.8bo.19@gated-at.bofh.it> <4Rzh.h8.25@gated-at.bofh.it> <4WSg.5H7.21@gated-at.bofh.it> <5h0y.5ht.25@gated-at.bofh.it> <5ldB.2cK.1@gated-at.bofh.it>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Fri, 4 Jul 2003 14:38:31 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I did a ps ax|grep -w D, and I got:

>ps ax|grep -w D
 2205 ?        S      0:00 smbd -D
 2209 ?        S      0:00 nmbd -D
 2337 pts/0    S      0:00 grep -w D

And the Load Average still is incompatible with the use of the CPUs:

14:34:53  up 11 min,  1 user,  load average: 1.35, 1.38, 0.85
86 processes: 85 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:   0.1% user   1.0% system    0.0% nice   0.0% iowait  97.0%
idle
CPU1 states:   0.0% user   1.0% system    0.0% nice   0.0% iowait  98.0%
idle
Mem:   513172k av,  340916k used,  172256k free,       0k shrd,   11904k
buff
                    242200k actv,   24552k in_d,   15120k in_c
Swap: 1060088k av,      40k used, 1060048k free                  254744k
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
   29 root      15   0     0    0     0 SW    0.9  0.0   0:03   1 raid1syncd

[]s
Slepetys


----- Original Message ----- 
From: "Matthias Andree" <matthias.andree@gmx.de>
Newsgroups: linux.kernel
Sent: Thursday, July 03, 2003 8:00 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> On Thu, 03 Jul 2003, Roberto Slepetys Ferreira wrote:
>
> > Meanning that the Load Average is incompatible with the use of the CPUs.
>
> To find the stuck process that pushes your LA up, try: ps ax | grep -w D
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


