Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132868AbRDEUGS>; Thu, 5 Apr 2001 16:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbRDEUGJ>; Thu, 5 Apr 2001 16:06:09 -0400
Received: from [216.84.120.7] ([216.84.120.7]:20740 "EHLO mail.wrldcom.com")
	by vger.kernel.org with ESMTP id <S132868AbRDEUF6>;
	Thu, 5 Apr 2001 16:05:58 -0400
Message-ID: <50282217D047D411997400805FEAAA81B1AE12@mail.voicelink>
From: Stephen Burns <sburns@wave3com.com>
To: linux-kernel@vger.kernel.org
Subject: Groups maximum
Date: Thu, 5 Apr 2001 14:59:40 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I have checked out the archives, and I found an old post regarding this.
The solution in the post, however, did not work for me.  I am attempting to
raise the maximum 32 group per user limit on my 2.4.2 kernel.  I patched
both linux/include/linux/limits.h and the asm-i386/param.h, replacing the
default "32" with "256."  My glibc is 2.1.2.  When I make clean, and
recompile the kernel, it boots fine but I am still limited to 32 groups.  I
don't need to do anything with glibc since it is of the 2.1 or greater
category, correct?  Any ideas, hints, tricks?  Thanks a ton for your help,
please CC me as I've not been approved yet as a member of this list.



