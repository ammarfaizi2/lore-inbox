Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAXNSu>; Wed, 24 Jan 2001 08:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRAXNSk>; Wed, 24 Jan 2001 08:18:40 -0500
Received: from smtp6.mail.yahoo.com ([128.11.69.103]:31242 "HELO
	smtp6.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129406AbRAXNSd>; Wed, 24 Jan 2001 08:18:33 -0500
X-Apparently-From: <mahadev?kc@yahoo.com>
Message-ID: <000b01c08608$427a8540$2e00a8c0@kcmahadev>
From: "Mahadev K Cholachagudda" <mahadev_kc@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Cc: <crossgcc@sources.redhat.com>, <gcc-help@gcc.gnu.org>
Subject: Why only Linux uses GCC to compile the source code. please help
Date: Wed, 24 Jan 2001 18:49:13 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,

Please include ****mailto:mahadev_kc@yahoo.com ***** in the reply list
******as i am not a member of the list******.

After i am going through the some part of the linux code, i wrote the
following. Please review it and if you have any additions/modifications or
comments please let me know.

Your help is really needed.

Thanks for any help,

Mahadev K Cholachagudda


The document is as below.

Introduction:

This document describes about the features of gcc which are very much
necessary to compile the Linux and also about the features that an 'x'
compiler does not have if used to compile the Linux.

Details:

1. The GCC has an explicit inline declaration for functions. So this option
may enable the calling function to have the contents of some global
variables in particular register.

2. The GCC has an support for inline assembly with 'C' expression operands
which can be used in 'C' functions.

3. The GCC has a support for including the 'C' header files into the
assembly source files.


The problems if one uses 'x' compiler other than GCC.
=====================================================

1. He/she may not get the features of GCC listed above into the 'x'
compiler.

2. The Linux kernel mainly uses GCC. If the Linux kernel is made to compile
using 'x' compiler other than GCC, then code updation will take time for 'x'
compiler if a newer version or patch of Linux released.

3. The Linux code may have some code which is purely based upon the data
types e.g. for one processor the unsigned long may be 32 bits or 16 bits.




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
