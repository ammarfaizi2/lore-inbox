Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLOEfA>; Thu, 14 Dec 2000 23:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOEeu>; Thu, 14 Dec 2000 23:34:50 -0500
Received: from web9407.mail.yahoo.com ([216.136.129.23]:22536 "HELO
	web9407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129257AbQLOEee>; Thu, 14 Dec 2000 23:34:34 -0500
Message-ID: <20001215040404.89406.qmail@web9407.mail.yahoo.com>
Date: Thu, 14 Dec 2000 20:04:04 -0800 (PST)
From: Lee Reynolds <kelticman1972@yahoo.com>
Subject: Question about RTC interrupts on i386
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reading the book Linux Internals by Moshe Bar. 
Early on he describes the use of the real time clock
to generate an interrupt 100 times a second.  He
explains that this value was chosen early in the
development cycle of the linux kernel and is therefore
relatively low compared to what current hardware can
make good use of.  He mentions that the alpha port of
linux uses a 1024Hz interrupt rate and that patches
have been made for the Intel kernel to give it the
same rate while maintaining the interrupt rate that
appears to userland  programs such as top at 100Hz.

I'm just wondering what the benefits of increasing
this value are and whether these patches are going to
be included in 2.4?

Thanks,
Lee Reynolds

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
