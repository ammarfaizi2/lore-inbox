Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTLBOpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTLBOpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:45:24 -0500
Received: from web20712.mail.yahoo.com ([66.163.169.153]:42366 "HELO
	web20712.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261563AbTLBOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:45:23 -0500
Message-ID: <20031202123323.73771.qmail@web20712.mail.yahoo.com>
Date: Tue, 2 Dec 2003 04:33:23 -0800 (PST)
From: kernwek jalsl <edityacomm@yahoo.com>
Subject: 2.4.20 page cache information
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone;

On my embedded system having 64MB of RAM and no swap,
I see the  following information on opening
/proc/meminfo:

       total:    used:    free:  shared: buffers: 
cached:
Mem:  62894080 47947776 14946304        0  4964352
23674880
Swap:        0        0        0
MemTotal:        61420 kB
MemFree:         14596 kB
MemShared:           0 kB
Buffers:          4848 kB
Cached:          23120 kB
SwapCached:          0 kB
Active:          32340 kB
ActiveAnon:      10760 kB
ActiveCache:     21580 kB
Inact_dirty:         0 kB
Inact_laundry:    6336 kB
Inact_clean:       236 kB
Inact_target:     7780 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        61420 kB
LowFree:         14596 kB
SwapTotal:           0 kB
SwapFree:            0 kB

As I see the total memory belonging to page cache is 
23MB and the anonymous list is 10MB. But if I count
the RSS values for all the processes running on the
system, it hardly comes to 15MB. Where is the rest of
the 18MB? If I understand the "cached:" = (pages in
the page cache - buffer cache). Even if I am doing
lots of file activity; I cannot imagine the file
system reads and writes holding up 18MB of the page 
cache. Am I missing something here?

Thanks in advance
Editya

__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
