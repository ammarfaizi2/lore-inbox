Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287089AbRL2CVU>; Fri, 28 Dec 2001 21:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287084AbRL2CVK>; Fri, 28 Dec 2001 21:21:10 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:12723 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287089AbRL2CU4>; Fri, 28 Dec 2001 21:20:56 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Phil Oester <kernel@theoesters.com>
Subject: RE: 2.4.17 still croaks under heavy load
Date: Sat, 29 Dec 2001 03:20:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011229022104Z287089-18284+8597@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester worte:
>
> No RAID1 on disks.
>
> Here's /proc/meminfo within 1 minute of the box dying last night:
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  1054371840 1044684800  9687040        0  7802880 834752512
> Swap: 535797760  7626752 528171008
> MemTotal:      1029660 kB
> MemFree:          9460 kB
> MemShared:           0 kB
> Buffers:          7620 kB
> Cached:         811872 kB
> SwapCached:       3316 kB
> Active:         231880 kB
> Inactive:       747344 kB
> HighTotal:      131072 kB
> HighFree:         1028 kB  <---------  See comment below
> LowTotal:       898588 kB
> LowFree:          8432 kB
> SwapTotal:      523240 kB
> SwapFree:       515792 kB
>
> The HighFree value was at 2044 for the prior hour.  It went to 1028
> within 1 minute of the box freezing.  Out of HighMem???
>
> Here's vmstat within 30 seconds of freezing:
>
>    procs                      memory    swap          io     system
> cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
> sy  id
>  1  0  0   7448   9536   7616 812092   0   0   932     2  235   577  50
> 1  49
>
> Seems VM related.

Hello Phil,

can you please try Andrea Arcangeli's 10_vm-21?
ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2/10_vm-21

I think we need more "pressure" to get these "fixes" into 2.4.18...

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

