Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135692AbRDXQGy>; Tue, 24 Apr 2001 12:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135695AbRDXQGo>; Tue, 24 Apr 2001 12:06:44 -0400
Received: from mx.ma.nma.ne.jp ([61.125.128.21]:4773 "HELO mx.ma.nma.ne.jp")
	by vger.kernel.org with SMTP id <S135688AbRDXQGZ>;
	Tue, 24 Apr 2001 12:06:25 -0400
Message-ID: <3AE5A483.FCF3F99@ma.nma.ne.jp>
Date: Wed, 25 Apr 2001 01:06:27 +0900
From: Masaki Tsuji <jammasa@ma.nma.ne.jp>
X-Mailer: Mozilla 4.75 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can't read SCSI TAPE
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sirs,

Although 'tar' can write to SCSI-TAPE, can't read from.
'tar' reports ....

......
-rw-r--r-- root/root    xxxxx 2001-xx-xx 01:23 usr/bin/xxxxxx
tar: Skipping to next file header                            <------"A"
-rw-r--r-- root/root    xxxxx 2001-xx-xx 01:23 usr/bin/xxxxxxx
......


"A" means written data is wrong, doesn't it???


Thanks for any help.

------------------------------------------
Detailed ->

System...
Kernel : 2.2.11 + raid0145-19990824-2.2.11.gz
          or
         2.2.11
tar    : GNU tar 1.12
mt     : mt-st v. 0.4
glibc2 : glibc-2.0.7pre6

Hardware...
Mother   : Intel Celeron x2 (SMP)
TAPE drv : SONY SDT-9000
TAPE     : DDS1 DDS2 DDS3
SCSI card: AHA-1542
Cable    : SCSI-2 Hi-impeadance , length 0.5m
------------------------------------------

-- 
Masaki Tsuji
