Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316115AbSEJU1t>; Fri, 10 May 2002 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316116AbSEJU1s>; Fri, 10 May 2002 16:27:48 -0400
Received: from mail.eunet.ch ([146.228.10.7]:37131 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S316115AbSEJU1s>;
	Fri, 10 May 2002 16:27:48 -0400
Message-ID: <3CDC4962.4B9393D7@dial.eunet.ch>
Date: Fri, 10 May 2002 22:27:46 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: NFS problem after 2.4.19-pre3, not solved
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond, hi Andrea, hi All

In production environment, since >6 months,
ethernet 10Mbits/s, on backup_machine
mount -t nfs production_machine /mnt.

find `listing from production_machine` | \
cpio -pdm backup_machine

Volume ~320MB, nearly constant.

Medium times:

2.4.17-rc1aa1: 1m58s, _the_ champion !!!

all later's, e.g.:

2.4.19-pre8aa2; 4m35s
2.4.19-pre8-ac1: 4m00s
2.4.19-pre7-rmap13a: 4m02s
2.4.19-pre7: 4m35s
2.4.19-pre4: 4m20s

the last usable was:

2.4.19-pre3: 2m35s, _not_ a champion

All benchmarks don't reflect
some production needs,
<2 minutes or >4 minutes
is a great difference !!!

Mario, not in lkml,
but active reader (and tester).
