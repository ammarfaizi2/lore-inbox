Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTDPPSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDPPSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:18:04 -0400
Received: from web12407.mail.yahoo.com ([216.136.173.134]:6454 "HELO
	web12407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264513AbTDPPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:18:03 -0400
Message-ID: <20030416152956.76292.qmail@web12407.mail.yahoo.com>
Date: Wed, 16 Apr 2003 08:29:56 -0700 (PDT)
From: Amol Lad <dal_loma@yahoo.com>
Subject: sending signal to a kernel thread
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@amol 5]# ps -ef | grep kswapd | grep -v grep
root         5     0  0 Apr04 ?        00:00:49
[kswapd]

[root@amol 5]# kill -9 5
[root@amol 5]# 

[root@amol 5]# pwd
/proc/5

[root@amol 5]# cat status
Name:   kswapd
State:  S (sleeping)
Tgid:   0
Pid:    5
PPid:   0
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 32
Groups:
SigPnd: 0000000000000100
SigBlk: ffffffffffffffff
SigIgn: 0000000000000000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000ffffffff
CapEff: 00000000fffffeff
----------------------------------------

Is it ok to at all permit sending signal to kernel
thread ? 


__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com
