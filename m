Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSGBH4N>; Tue, 2 Jul 2002 03:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSGBH4M>; Tue, 2 Jul 2002 03:56:12 -0400
Received: from smtp01.web.de ([194.45.170.210]:12568 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S316668AbSGBH4L>;
	Tue, 2 Jul 2002 03:56:11 -0400
Date: Tue, 2 Jul 2002 09:58:32 +0200
From: Timo Benk <t_benk@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timo Benk <t_benk@web.de>
Subject: syscall definitions
Message-ID: <20020702075832.GB5604@toshiba>
Reply-To: Timo Benk <t_benk@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Do you know any good reference of the linux syscalls,
including there method bodies?

I wondered also if the syscalls are somewhere predefined,
so that i don't need to use the sys_call_table. Also i am not
sure if i use them the "right" way:

---<snip>---
int (*do_munmap2)(void *start, size_t length);         

void initialize_syscalls()                                                          
{                                                                               
        do_munmap2 = sys_call_table[__NR_munmap];                               
}                                                                               
---<snap>---

Do i need such a initialize() function to initialize all
the syscalls i intend to use?

Thanks in advance,
-timo
	
-- 
gpg key fingerprint = 6832 C8EC D823 4059 0CD1  6FBF 9383 7DBD 109E 98DC

