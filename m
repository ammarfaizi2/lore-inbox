Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275438AbTHJABv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275440AbTHJABv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 20:01:51 -0400
Received: from fe2-cox.cox-internet.com ([66.76.2.39]:10171 "EHLO
	fe2.cox-internet.com") by vger.kernel.org with ESMTP
	id S275438AbTHJABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 20:01:50 -0400
Message-ID: <003501c35ed2$a6ff5400$71f14c42@coxinternet.com>
From: "Matthew Mullins" <mokomull@cox-internet.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3 Makefile
Date: Sat, 9 Aug 2003 19:02:13 -0500
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

The makefile bundled with 2.6.0-test3 won't install the modules correctly.
'make modules' compiles the modules to *.o, but 'make modules_install'
expects to find them as *.ko.

If I could find some documentation on the makefiles (or makefiles in
general), I'd be able to submit a patch.

-MrM

