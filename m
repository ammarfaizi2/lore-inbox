Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279467AbRKIGVn>; Fri, 9 Nov 2001 01:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279470AbRKIGVZ>; Fri, 9 Nov 2001 01:21:25 -0500
Received: from [203.6.240.4] ([203.6.240.4]:22280 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id <S279467AbRKIGVW>; Fri, 9 Nov 2001 01:21:22 -0500
Message-ID: <370747DEFD89D2119AFD00C0F017E66150B29A@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: linux-kernel@vger.kernel.org
Subject: Assertion failure wth ext3 on standard Redhat 7.2 kernel
Date: Fri, 9 Nov 2001 17:20:58 +1100 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have recently upgraded my machine to redhat 7.2 (from redhat 6.2) and I am
constantly (eg < 1 hour of uptime) getting kernel crashes which I believe
are relating to ext3.  I know I should submit this to redhat's bugzilla, but
before I do I was hoping someone on the list might want to comment as I am
sure it is probably something I am doing wrong.

The machine has previously been rock solid, and the only hardware change I
have made recently is to add an extra 64M of RAM (Total 128MB).  I have run
memtest86 on it for 10 hours with no errors reported.

The last error I get is
Assertion failure in __journal_file_buffer() at transaction.c:1953:
"jh->b_jlist < 9".  I can still switch between consoles, but cannot do much
else other than press the reset button :(  

The machine is a Pentium233MMX with a 430FX (Trition I) motherboard.

Please let me know if I can gather any more information to help track this
down.

-Robert
