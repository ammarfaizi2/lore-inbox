Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbQKHVQa>; Wed, 8 Nov 2000 16:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129937AbQKHVQU>; Wed, 8 Nov 2000 16:16:20 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:5886 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129915AbQKHVQD>; Wed, 8 Nov 2000 16:16:03 -0500
Date: Wed, 08 Nov 2000 15:15:59 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <13202.973717711@ocs3.ocs-net>
In-Reply-To: Your message of "Wed, 08 Nov 2000 14:09:43 MDT."<20001108200949Z129150-31179+2040@vger.kernel.org>
Subject: Re: multiple definition of `__module_kernel_version'
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001108211614Z129915-31179+2047@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Keith Owens <kaos@ocs.com.au> on Thu, 09 Nov 2000
08:08:31 +1100


> In 2.2 you have to
> #define __NO_VERSION__ before including module.h in all of the module
> objects except one.  Search 2.2 drivers for __NO_VERSION__ to see
> examples of this.

If I do that, I get this error:

../support/schedule.h:16: parse error

and line 16 says:

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
