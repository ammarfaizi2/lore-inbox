Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTFBLm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTFBLm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:42:26 -0400
Received: from zukmail03.zreo.compaq.com ([161.114.128.27]:17160 "EHLO
	zukmail03.zreo.compaq.com") by vger.kernel.org with ESMTP
	id S262174AbTFBLmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:42:23 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: /proc/meminfo
Date: Mon, 2 Jun 2003 13:55:47 +0200
Message-ID: <224CFA9643B4CE4BA18137CF73DB2F32020E0DA6@broexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/meminfo
Thread-Index: AcMo/WrDZB5yqWq1SHu5tPtES5ggxQAAFx5g
From: "Roets, Chris (Tru64&Linux support)" <chris.roets@hp.com>
To: "linux-kernel@vger.kernel.org" <'linux-kernel@vger.kernel.org'>
X-OriginalArrivalTime: 02 Jun 2003 11:55:48.0527 (UTC) FILETIME=[E84663F0:01C328FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you look at /proc/meminfo, what values to you need to add to each
other
to get to the total memory ?
ok, used and free (256241664  5042176),
but then how do you come to used :

Active + Inactive_dirty + Inactive_clean + ....
in the case below, I can't find where 57360 Kb are allocated to.
I looked ad slabinfo, but cold get to the total niether
Does anybody have the calculation to get to the total ?
Thanks,
Chris

[root@tanos4 mypdc]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  261283840 256241664  5042176    81920  9867264 177315840
Swap: 536862720   434176 536428544
MemTotal:       255160 kB
MemFree:          4924 kB
MemShared:          80 kB
Buffers:          9636 kB
Cached:         172736 kB
SwapCached:        424 kB
Active:           9196 kB
Inact_dirty:    132844 kB
Inact_clean:     40836 kB
Inact_target:      884 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255160 kB
LowFree:          4924 kB
SwapTotal:      524280 kB
SwapFree:       523856 kB
NrSwapPages:    130964 pages

Chris Roets
HP Customer support
Tru64 and Linux support
HP Belgium
www.hp.be

Chris.Roets@hp.com
Tel +32 2 729.77.44
http://www.roets.tk 
