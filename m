Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbVLSJSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbVLSJSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbVLSJSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:18:47 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:58564 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932693AbVLSJSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:18:46 -0500
Message-ID: <000001c6047c$a2458a40$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: buffer cache question
Date: Sun, 18 Dec 2005 22:09:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I use 4 disk nodes with NBD.
All of my nodes have 2GB ram.

But the buffer cache newer rise over 830MB.

Is there some limit?
Where can i change this limit? (if it is)

Thanks,
Janos

[root@st-0001 root]# free
             total       used       free     shared    buffers     cached
Mem:       2073152     933188    1139964          0     836776      43416
-/+ buffers/cache:      52996    2020156
Swap:            0          0          0
[root@st-0001 root]# cat /proc/meminfo
MemTotal:      2073152 kB
MemFree:       1139012 kB
Buffers:        835928 kB
Cached:          43448 kB
SwapCached:          0 kB
Active:          12872 kB
Inactive:       871424 kB
HighTotal:     1179584 kB
HighFree:      1129764 kB
LowTotal:       893568 kB
LowFree:          9248 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           9104 kB
Slab:            30248 kB
CommitLimit:   1036576 kB
Committed_AS:    15428 kB
PageTables:        408 kB
VmallocTotal:   114680 kB
VmallocUsed:       196 kB
VmallocChunk:   114476 kB
[root@st-0001 root]#

