Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271001AbRIGDM1>; Thu, 6 Sep 2001 23:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271007AbRIGDMR>; Thu, 6 Sep 2001 23:12:17 -0400
Received: from andiamo.com ([161.58.172.50]:45304 "EHLO andiamo.com")
	by vger.kernel.org with ESMTP id <S271001AbRIGDMF>;
	Thu, 6 Sep 2001 23:12:05 -0400
From: "Rajeev Bector" <rbector@andiamo.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Question about kernel threads
Date: Thu, 6 Sep 2001 20:08:09 -0700
Message-ID: <GIEMIEJKPLDGHDJKJELAMEBNCHAA.rbector@andiamo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have a simple question about kernel threads. Can they
open and close files just like user level processes ?
(by using sys_open()) etc. directly ? Are there any
side issues that we need to be aware about when doing that ?

I have a userlevel library (that client programs will link with
to get access to a kernel module) and there is a requirement
that other kernel modules (using kernel threads) wants to
use the same library to get access to other kernel module.
So I am having to port the library to work in kernel space.
(since the library opens and closes certain device drivers, I 
am wondering if that'll work seemlessly from kernel space)

Thanks in advance for your answers !

regards,
Rajeev



