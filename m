Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272765AbTHFJt1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270697AbTHFJt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:49:27 -0400
Received: from [81.193.98.149] ([81.193.98.149]:12672 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S272765AbTHFJt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:49:26 -0400
Message-ID: <3F30CFC1.1090205@toxyn.org>
Date: Wed, 06 Aug 2003 10:52:01 +0100
From: RaTao <ratao@toxyn.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: linux-2.6.0-linux-kernel@vger.kernel.orgtest2-mm4 O_DIRECT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

While testing linux-2.6.0-test2-mm4 I noticed two things:

- O_DIRECT doesn't work, at least in ext3, with block size different 
from filesystem's blocksize. (It doesn't work with 512 bs, at least).
This works in 2.6.0-test2, from 512 to 4096.

- vmstat doesn't show bi/bo for O_DIRECT's disk access.
Tested with filesystem's bs alignment.
This works in 2.6.0-test2.
(This one can be a feature, not a bug. But I really don't know)

Just to let you know! :)

If I can help with something feel free to ask. I tried to review -mm4 
but it's too big for me so I can't point where the "problem" is... 
Anyway, I suspect the AIO stuff ;)

Have fun,
RaTao



