Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbRGVX6R>; Sun, 22 Jul 2001 19:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268111AbRGVX6G>; Sun, 22 Jul 2001 19:58:06 -0400
Received: from hinako.ambusiness.com ([64.59.51.7]:24838 "EHLO
	Hinako.AMBusiness.com") by vger.kernel.org with ESMTP
	id <S268110AbRGVX5x>; Sun, 22 Jul 2001 19:57:53 -0400
Message-ID: <002001c1130a$0a98a0a0$9865fea9@optima>
From: "Anthony Barbachan" <barbacha@Hinako.AMBusiness.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: PC Speaker ocassionally hangs on an FIC VA-503+ under 2.4.[567]
Date: Sun, 22 Jul 2001 19:57:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

    I have noticed the following problem on a system which I installed on a
FIC VA-503+ motherboard with a 450 Mhz K6-2 CPU.  This problem is consistent
and is present in kernels from 2.4.5 - 2.4.7.  The problem is that
occasionally the PC speaker will hang when making a beep.  When the hang
occurs the beep stays on, the screen blanks out, and all processing on the
system appears to hang.  After a few moments the system appears to unhang
itself, the screen returns, and everything returns to normal.  While it is
not consistent, as not all beeps from the PC speaker causes the hanging, but
it is frequent enough to make working on the console almost unbearable.  The
hanging behavior can be easily reproduced if I do anything to cause multiple
system beeps; such as pressing tab a few times on an empty bash prompt which
causes a beep to occur from the auto command completion feature as it warns
you that multiple possible substitutions exist for your command completion
request.

    Is this a known bug?

    If so is there a fix for it?

    If it is not know how can I help in resolving this?  (No oops exists so
nothing to send from there)

