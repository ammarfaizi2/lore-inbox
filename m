Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHOXBl>; Wed, 15 Aug 2001 19:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbRHOXBa>; Wed, 15 Aug 2001 19:01:30 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:12299 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S268133AbRHOXBX>;
	Wed, 15 Aug 2001 19:01:23 -0400
Date: Thu, 16 Aug 2001 00:01:26 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Subject: old_select vs sys_select
Message-ID: <Pine.LNX.4.32.0108152359270.1907-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the VAX port I'm updating my syscalls to match some of the other
platforms,

why do some platforms defined old_select and some just use sys_ni_syscall
for the system call number for the old_select... is this purely to deal
with old applications that were compiled against old kernels, and so this
means I don't have to implement old_select on the VAX at all..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


