Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTACAmH>; Thu, 2 Jan 2003 19:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTACAmH>; Thu, 2 Jan 2003 19:42:07 -0500
Received: from smtp.comcast.net ([24.153.64.2]:1604 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267357AbTACAmF>;
	Thu, 2 Jan 2003 19:42:05 -0500
Date: Thu, 02 Jan 2003 19:50:03 -0500
From: Jerry McBride <mcbrides9@comcast.net>
Subject: mkfs help, please.
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <0H84002VD4UUI0@mtaout07.icomcast.net>
Organization: TEAM LINUX
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.8claws (GTK+ 1.2.8; i586-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-message-flag: Join the Wave and install Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm setting up a new computer with a 60gig maxtor. I'd like a 100meg /boot at
the very top of the disk to get around 1024 cylinder bios restriction with out
have to do anything special. This has to be as vanilla as possible.

After fdisking the disk the way I want it, when I try to mkfs.ext2 the first
partition I get this message: mkfs.ext2: Attempt to write block from
filesystem resulted in short write zeroing block 262576 at end of filesystem

In all my time on linux, I've never seen this one before. Any tips? The
partition giving this message is the first primary, 256meg on that drive. I've
tried specifying no reserve, blocksize=1024 and no change with the message.


-- 

******************************************************************************
                     Registered Linux User Number 185956
          http://groups.google.com/groups?hl=en&safe=off&group=linux
             Join me in chat at #linux-users on irc.freenode.net
     7:30pm  up 40 days, 21:09, 10 users,  load average: 0.76, 1.06, 1.15
