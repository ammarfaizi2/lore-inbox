Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135210AbRD3LOt>; Mon, 30 Apr 2001 07:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135198AbRD3LOi>; Mon, 30 Apr 2001 07:14:38 -0400
Received: from www.topmail.de ([212.255.16.226]:8648 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S135211AbRD3LOV>;
	Mon, 30 Apr 2001 07:14:21 -0400
Message-ID: <000701c0d166$b3285c50$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Q: Optimisation
Date: Mon, 30 Apr 2001 11:12:19 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
if I want to compile a complete linux system
with the new-style CFLAGS and kernel opts so
that it RUNS on 486DX and is OPTIMISED for
Pentium, which options do I have to choose in

 - kernel config  (in 2.0.33 I used 586 for this, but since
                    2.2 I can't be sure that it runs on 486 then)

 - kernel CFLAGS
 - user CFLAGS

I think of CFLAGS=-march=i586 -mcpu=i486 -Os -fomit-frame-pointer -Wall

Do programmes compiled so really run on a 486 w/ FPU, and can I use
these CFLAGS (-Os e.g. instead of -O2) for the kernel?

I really want _small_ code (e.g. for floppy systems) and it doesn't
need to be the super-fastest, but it simply has to work.

TIA
-mirabilos

