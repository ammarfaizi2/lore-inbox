Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135867AbREDGtT>; Fri, 4 May 2001 02:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135869AbREDGtJ>; Fri, 4 May 2001 02:49:09 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:37334 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S135867AbREDGtD>; Fri, 4 May 2001 02:49:03 -0400
Date: Thu, 3 May 2001 22:29:04 +0100
From: Anders Karlsson <anders.karlsson@meansolutions.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: FS Structs
Message-ID: <20010503222904.A505@inspiron.ssd.hursley.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Many thanks for a very good and solid piece of software in the Linux
kernel. It has been very useful to me for several years now.

I am not subscribed to the list, so if I could be CC'd on eventual
replies I would be grateful.


I have a question regarding some of the parts of the overall
filesystem structure in the 2.4 kernel. (Kernel 2.4.[34].)
In the file fs/super.c the structure `sb' is used, that is the
superblock. As a part of that structure (reference include/linux/fs.h)
is `struct list_head s_locked_inodes;'.

The thing I can not understand at the moment is the `struct list_head'
(reference include/linux/list.h) which looks very odd. How can I find
which inodes are in the `s_locked_inodes' list?? All I want to do is
to loop through the list and see each open inode in turn, is there any
documentation for this, or is there any helpful soul out there that
could give me any pointers?

Many thanks in advance,

-- 
        Anders Karlsson
e-mail: anders.karlsson@meansolutions.com

   *** PGP Encrypted E-Mail Is Prefered - PGP Key On Request ***
