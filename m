Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbRL3NMl>; Sun, 30 Dec 2001 08:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287399AbRL3NMb>; Sun, 30 Dec 2001 08:12:31 -0500
Received: from smtp02.web.de ([217.72.192.151]:22303 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S287403AbRL3NMO>;
	Sun, 30 Dec 2001 08:12:14 -0500
Message-ID: <004801c19133$9bc91210$0dfda8c0@mausi>
From: "Tobias Reinhard" <TRTracer@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: SIS-Driver
Date: Sun, 30 Dec 2001 14:12:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I am doing something wrong but I dicovered a problem with the Linux
2.4.17,XFree 4.1.0 and the SIS-DRM-Driver.

If I choose the SIS to compile as module the Linux-Menuconfig UNDEF
CONFIG_DRM_SIS - this result in a compile-error when compiling XFree. I have
to comfigure the SIS to be included in the kernel. But this is not what I
want because I use the same kernel on differend computer - but at least
XFree compiles. But now Linux does not compile because it wants that I
include the SIS-FB driver in the kernel. Another thing that i dont want! :-)

What am I doing wrong, or is that a bug? I solved it by setting up a Kernel
with all SIS-DRM included, compile X and then removed them. ATM I am unable
to test if the SIS-DRM really runs with that configuration...

Tobias


