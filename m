Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbTCTV7r>; Thu, 20 Mar 2003 16:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbTCTV7q>; Thu, 20 Mar 2003 16:59:46 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:55779 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262648AbTCTV65>; Thu, 20 Mar 2003 16:58:57 -0500
Message-ID: <004c01c2ef2d$77fd7020$fe78a8c0@a>
From: Andreas.Fey@t-online.de (Andreas Fey)
To: <linux-kernel@vger.kernel.org>
Subject: Using modules to avoid the need of a reboot during development
Date: Thu, 20 Mar 2003 23:09:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to add a custom routine to the tcp-code in the kernel 2.4.18.
Unfortunately I have to reboot the machine everytime I have made changes to
the kernel.
So my question is: Can I avoid the need of a reboot using a selfmade kernel
module ?

In tcp.c I want to call a dummy function. And when I insert the module it
should intercept the dummy function so that the code in the module is
executed instead of the function  in tcp.c. This would be great because all
the things I have to do is compiling and reinserting the module everytime I
have changed something in the code.

Can this be done in the 2.4 kernel ? Is this the right way to safe time
during kernel development or is there an easier way ?

Thank You, Andy.



