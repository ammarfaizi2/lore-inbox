Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135696AbRDSUqJ>; Thu, 19 Apr 2001 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135698AbRDSUp7>; Thu, 19 Apr 2001 16:45:59 -0400
Received: from mail.clemson.edu ([130.127.28.87]:2688 "EHLO CLEMSON.EDU")
	by vger.kernel.org with ESMTP id <S135696AbRDSUpo>;
	Thu, 19 Apr 2001 16:45:44 -0400
Message-ID: <002301c0c911$e77c6490$3cac7f82@crb50>
From: "Hai Xu" <xhai@CLEMSON.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: A little problem.
Date: Thu, 19 Apr 2001 16:47:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have a question about the kernel used by the RedHat. I am using Redhat 7.0
and upgrade the Linux Kerenl from their original 2.2.16 to 2.2.18. But when
I compile some modules, it said my kernel is 2.4.0. I check the
/usr/include/linux/version.h as follows, found that it shows I am using
Kernel 2.4.0.

#include <linux/rhconfig.h>
#if defined(__module__smp)
#define UTS_RELEASE "2.4.0-0.26smp"
#else
#define UTS_RELEASE "2.4.0-0.26"
#endif
#define LINUX_VERSION_CODE 132096
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))


 But when I "cat /proc/version", it will give me:

Linux version 2.2.18-rtl (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Thu Apr 5 23:10:12 EDT 2001

So I am totally confused by the RedHat. So could you please tell me how to
solve this problem?

I just want to use the 2.2.18 without the 2.4.0. I did not install this one,
I also do not know where this one comes from.

Thanks in advance.
Hai Xu



