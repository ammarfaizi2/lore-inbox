Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDXABY>; Mon, 23 Apr 2001 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132586AbRDXABQ>; Mon, 23 Apr 2001 20:01:16 -0400
Received: from www.resilience.com ([209.245.157.1]:43397 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132584AbRDXABA>; Mon, 23 Apr 2001 20:01:00 -0400
Message-ID: <3AE4C30B.1E8371A7@resilience.com>
Date: Mon, 23 Apr 2001 17:04:27 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel make dependancies question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I was looking at linux/drivers/Makefile and noticed that "sound" (among
others) was always put into the kernel whether it was configured on or
not.  Is there some reason for this?

Also, in linux/Rules.make, "fastdep:" is making dependancies on
"ALL_SUB_DIRS" which is "subdir-y", "subdir-m", "subdir-n" and
"subdir-", why is this?  It makes more sense that it just make
dependancies for "subdir-y" and "subdir-m" as the rest don't matter.

If these types of things are errors, I can make a patchfile, just let me
know what the proper behavior is.

Thanks,

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
