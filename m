Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKOAO6>; Tue, 14 Nov 2000 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbQKOAOs>; Tue, 14 Nov 2000 19:14:48 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:24061 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129170AbQKOAOp>; Tue, 14 Nov 2000 19:14:45 -0500
Date: Tue, 14 Nov 2000 17:44:42 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <12388.974245302@ocs3.ocs-net>
In-Reply-To: Your message of "Tue, 14 Nov 2000 17:35:37 MDT."
Subject: Re: "couldn't find the kernel version the module was compiled for" - help!
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001115001445Z129170-521+233@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Keith Owens <kaos@ocs.com.au> on Wed, 15 Nov 2000
10:41:42 +1100


> __NO_VERSION__ must be defined before #include <module.h>.  

It is:

#ifdef LINUX
#ifndef __ENTRY_C__
#define __NO_VERSION__
#endif
#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>

>Do it by hand.

I don't know what you mean by that.




-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
