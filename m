Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268921AbRG0S56>; Fri, 27 Jul 2001 14:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRG0S5s>; Fri, 27 Jul 2001 14:57:48 -0400
Received: from mail.clemson.edu ([130.127.28.87]:52461 "EHLO CLEMSON.EDU")
	by vger.kernel.org with ESMTP id <S268921AbRG0S5d>;
	Fri, 27 Jul 2001 14:57:33 -0400
Message-ID: <000901c116cd$c67b4a40$3cac7f82@crb50>
From: "Hai Xu" <xhai@CLEMSON.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: question about libc.a libgcc.a
Date: Fri, 27 Jul 2001 14:55:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2479.0006
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dear all,

I am focus on a device driver. I compile it to a model.o and try to insmod
it to kernel. But when do so, I will get:

unresolved symbol: __udividi3
unresolved symbol: __umoddi3

As someone tell me, I have to link the libgcc.a to my model.o. I did it but
I when I try to insmod the model.o, I will get segamentation fault.

The following are my link libraries.
#LIBS    =
$(MATLAB_ROOT)/rtw/c/lib/$(ARCH)/lrtwLib.a -L/usr/lib/gcc-lib/i386-redhat-li
nux/2.96 -lgcc -L/usr/lib -lm -lc $(EXT_LIB) $(S_FUNCTIONS_LIB)
$(INSTRUMENT_LIBS)

Please give me some ideas about it.

Thanks in advance
Hai Xu

