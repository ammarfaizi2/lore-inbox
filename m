Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbQLMXck>; Wed, 13 Dec 2000 18:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbQLMXca>; Wed, 13 Dec 2000 18:32:30 -0500
Received: from saltlake.cheek.com ([207.202.196.152]:60678 "EHLO
	saltlake.cheek.com") by vger.kernel.org with ESMTP
	id <S129541AbQLMXcO>; Wed, 13 Dec 2000 18:32:14 -0500
Message-ID: <3A37FFC9.19F05305@cheek.com>
Date: Wed, 13 Dec 2000 15:01:29 -0800
From: Joseph Cheek <joseph@cheek.com>
X-Mailer: Mozilla 4.73C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test12: eth0 trasmit timed out after one hour uptime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

after about an hour of uptime [and heavy HD usage] my ethernet just
died.  couldn't ping a thing.  syslog showed:

Dec 13 14:51:46 sanfrancisco kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Dec 13 14:51:46 sanfrancisco kernel: eth0: transmit timed out, tx_status
00 status e680.
Dec 13 14:51:46 sanfrancisco kernel:   Flags; bus-master 1, full 1;
dirty 3306(10) current 3322(10).
Dec 13 14:51:46 sanfrancisco kernel:   Transmit list 00000000 vs.
c7c732a0.
Dec 13 14:51:46 sanfrancisco kernel:   0: @c7c73200  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   1: @c7c73210  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   2: @c7c73220  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   3: @c7c73230  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   4: @c7c73240  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   5: @c7c73250  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   6: @c7c73260  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   7: @c7c73270  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   8: @c7c73280  length 8000002a
status 8001002a
Dec 13 14:51:46 sanfrancisco kernel:   9: @c7c73290  length 8000002a
status 8001002a
Dec 13 14:51:46 sanfrancisco kernel:   10: @c7c732a0  length 8000004b
status 0001004b
Dec 13 14:51:46 sanfrancisco kernel:   11: @c7c732b0  length 8000004b
status 0001004b
Dec 13 14:51:46 sanfrancisco kernel:   12: @c7c732c0  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   13: @c7c732d0  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   14: @c7c732e0  length 8000002a
status 0001002a
Dec 13 14:51:46 sanfrancisco kernel:   15: @c7c732f0  length 8000002a
status 0001002a

after reboot it works fine again [i'll give it an hour...]  test12-pre8
and before worked fine.  any ideas?

--
thanks!

joe

--
Joseph Cheek, Sr Linux Consultant, Linuxcare | http://www.linuxcare.com/
Linuxcare.  Support for the Revolution.      | joseph@linuxcare.com
CTO / Acting PM, Redmond Linux Project       | joseph@redmondlinux.org
425 990-1072 vox [1074 fax] 206 679-6838 pcs | joseph@cheek.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
