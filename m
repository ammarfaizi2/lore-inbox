Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBJUeu>; Sat, 10 Feb 2001 15:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBJUek>; Sat, 10 Feb 2001 15:34:40 -0500
Received: from webserver.giki.edu.pk ([210.56.13.8]:60175 "EHLO
	webserver.giki.edu.pk") by vger.kernel.org with ESMTP
	id <S129026AbRBJUec> convert rfc822-to-8bit; Sat, 10 Feb 2001 15:34:32 -0500
Message-ID: <00aa01c093a0$8cc9a6d0$a20ba8c0@hostel1.giki.edu.pk>
From: "Hasan Abbasi" <u970066@giki.edu.pk>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved Symbol error
Date: Sun, 11 Feb 2001 01:32:12 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to create a catcher module that will provide a distributed layer over the file system. To do this I am using a kernel module to intercept and pre process the open system call. However I need to use some functions such as strlen() and memcpy() etc. When I try to compile the module it compiles fine. Without any errors. However when I insert the module using insmod <module name> I get an error:
catcher.o: unresolved symbol strlen

I am compiling the module using -D__KERNEL__ -DMODULE -DLINUX options. Is there some thing else that I have to do to use the strlen function. 

All the examples that I have been able to access use this function, but I cannot even make the examples work. I am using Kernel 2.2.12-20, gcc version egcs-2.91.66. 

Since I am not subscribed to the kernel development list .. can you please reply directly to me at u970066@giki.edu.pk

Thankyou.

Hasan Abbasi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
