Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbQLTEhX>; Tue, 19 Dec 2000 23:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131135AbQLTEhN>; Tue, 19 Dec 2000 23:37:13 -0500
Received: from [216.136.130.52] ([216.136.130.52]:3077 "HELO
	web10102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130069AbQLTEhE>; Tue, 19 Dec 2000 23:37:04 -0500
Message-ID: <20001220040634.26347.qmail@web10102.mail.yahoo.com>
Date: Tue, 19 Dec 2000 20:06:34 -0800 (PST)
From: Al Peat <al_kernel@yahoo.com>
Subject: Purging the Buffer Cache
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: myself <al_peat@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Is there any way to completely purge the buffer
cache -- not just the write requests (ala 'sync' or
'update'), but the whole thing?  Can I just call
invalidate_buffers() or destroy_buffers()?

  I know, why in the world would a person do such a
thing?  Research.  It'd be easier for me to write a
little program or add it to a module than wait for a
reboot each time I need a clean buffer cache.

  Thanks in advance,
	Al
  

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
