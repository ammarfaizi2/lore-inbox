Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTAQQdR>; Fri, 17 Jan 2003 11:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTAQQdR>; Fri, 17 Jan 2003 11:33:17 -0500
Received: from cynosure.colorado-research.com ([65.171.192.72]:42115 "EHLO
	cynosure.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267609AbTAQQdQ>; Fri, 17 Jan 2003 11:33:16 -0500
Message-ID: <3E283265.4070401@cora.nwra.com>
Date: Fri, 17 Jan 2003 09:42:13 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "''Linux Kernel Mailing List ' '" <linux-kernel@vger.kernel.org>
Subject: kswapd in D uninterruptible sleep on 2.4.21-pre3-ac2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an SMP system running 2.4.21-pre3-ac2 with some odd behavior. 
 It's basically completely idle, but with a load average of 1.00, which 
I believe is due to "kswapd" being stuck in uninterruptible sleep:

040 D     0     7     1  0  75   0    -     0 down   ?        00:00:00 
kswapd

Can someone explain this behavior?

# free
             total       used       free     shared    buffers     cached
Mem:       2069940     300504    1769436          0     100804      48020
-/+ buffers/cache:     151680    1918260
Swap:      2096472       1204    2095268

Thank you,

   Orion Poplawski

