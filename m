Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTIBDtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 23:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTIBDtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 23:49:41 -0400
Received: from h011.c007.snv.cp.net ([209.228.33.239]:26336 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id S263452AbTIBDtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 23:49:41 -0400
X-Sent: 2 Sep 2003 03:49:39 GMT
Message-ID: <005e01c37105$1bddc600$323be90c@bananacabana>
From: "Chris Peterson" <chris@potamus.org>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: blank boot screen on linux-2.6.0-test4 (with workaround)
Date: Mon, 1 Sep 2003 20:48:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded a working Redhat 9 installation (linux-2.4.20) to
linux-2.6.0-test4. When I boot, I see the "Uncompressing Linux..." message,
but then the screen goes blank. I know the system did not crash because I
can blindly login and shutdown.

My previous kernel boot parameters included "vga=773" to give me 50 lines on
my laptop display (a Dell Latitude C400). If I remove "vga=773" and add
"video=vga16:off", then everything works correctly! If I include both
"vga=773 video=vga16:off", then I get the blank boot screen again.

Why does "vga=773" work with linux-2.4.20, but not linux-2.60-test4? Why
does linux-2.6.0-test4 require "video=vga16:off", but linux-2.4.20 does not?

thanks,
chris

