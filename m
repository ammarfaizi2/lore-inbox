Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277933AbRJITgo>; Tue, 9 Oct 2001 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277931AbRJITgZ>; Tue, 9 Oct 2001 15:36:25 -0400
Received: from mail.spylog.com ([194.67.35.220]:26549 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S277932AbRJITgN>;
	Tue, 9 Oct 2001 15:36:13 -0400
Date: Tue, 9 Oct 2001 23:32:40 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <129371054468.20011009233240@spylog.com>
To: =?ISO-8859-1?B?SmFrb2Ig2HN0ZXJnYWFyZA==?= <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org, admin@spylog.com
Subject: Re[2]: RAID sync
In-Reply-To: <20011002071949.B5302@unthought.net>
In-Reply-To: <1101445461994.20011001182753@spylog.com>
 <20011002071949.B5302@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, Jakob and all,

Tuesday, October 02, 2001, 9:19:49 AM, you wrote:

JØ> On Mon, Oct 01, 2001 at 06:27:53PM +0400, Oleg A. Yurlov wrote:
>> 
>>         Privet :-)
>> 
>>         Kernel 2.4.6.SuSE-4GB-SMP, 2 CPU, 2Gb RAM, 4 HDD SCSI, M/B Intel L440GX.
>> Messages from dmesg:
>> 
JØ> ...
>> md: sdc2 [events: 0000001e](write) sdc2's sb offset: 15815872
>> md: considering sdb2 ...
>> md:  adding sdb2 ...
>> md:  adding sda2 ...
>> md: created md0
>> md: bind<sda2,1>
>> md: bind<sdb2,2>
>> md: running: <sdb2><sda2>
>> md: now!
>> md: sdb2's event counter: 0000001c
>> md: sda2's event counter: 0000001d
>> md: superblock update time inconsistency -- using the most recent one
>> md: freshest: sda2
>> md0: max total readahead window set to 508k
>> md0: 1 data-disks, max readahead per data-disk: 508k
>> raid1: device sdb2 operational as mirror 1
>> raid1: device sda2 operational as mirror 0
>> raid1: raid set md0 active with 2 out of 2 mirrors
>> md: updating md0 RAID superblock on device
>> md: sdb2 [events: 0000001e](write) sdb2's sb offset: 15815872
>> md: sda2 [events: 0000001e](write) sda2's sb offset: 15815872
>> md: ... autorun DONE.
>> 
>>         Why RAID do not start synchronization ? It is normal ?

JØ> Doesn't it ?

        Really.

JØ> Try "cat /proc/mdstat"

JØ> Synchronization is a background operation - your array is functional
JØ> immediately.

        No,  synchronization  not  started,  /proc/mdstat  say  that  RAID is Ok
([UU]). /proc/mdstat checked immediately after booting.

JØ> (this behaviour was changed from the really really old RAID code in unpatched
JØ>  2.2 to standard 2.4)

        Neil already has given some explanations...

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

