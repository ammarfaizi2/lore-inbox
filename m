Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274896AbRIZJnB>; Wed, 26 Sep 2001 05:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274898AbRIZJmv>; Wed, 26 Sep 2001 05:42:51 -0400
Received: from web13509.mail.yahoo.com ([216.136.173.13]:33544 "HELO
	web13509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274896AbRIZJmq>; Wed, 26 Sep 2001 05:42:46 -0400
Message-ID: <20010926094312.95950.qmail@web13509.mail.yahoo.com>
Date: Wed, 26 Sep 2001 02:43:12 -0700 (PDT)
From: Alejandro Lucero <alejluther@yahoo.com>
Subject: block device driver + ext2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a block device driver. If I try to
write into the device using the block_write function
and I read after with block_read the behaviour is
fine. I can flush the buffers and the driver works ok.
But if I make a ext2 file system on the device I have
problems. If I copy one file to the new file system
and after I compare the two file, the command doesnt
give any diferences, but when I flush the buffers and
the cache pages the cp command gives me a lot of
differences. If I only flush the cache pages it works
fine.

I dont know if I'm forgetting something respect the
way the ext2 file system works.
I hope help. Thanks.

__________________________________________________
Do You Yahoo!?
Get email alerts & NEW webcam video instant messaging with Yahoo! Messenger. http://im.yahoo.com
