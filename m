Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTJZUlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 15:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTJZUlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 15:41:10 -0500
Received: from tomteboda.mdh.se ([130.243.76.141]:49552 "EHLO tomteboda.mdh.se")
	by vger.kernel.org with ESMTP id S263653AbTJZUlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 15:41:08 -0500
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] R8169 on 2.6.0-test9
Date: Sun, 26 Oct 2003 21:40:58 +0100
Message-ID: <062501c39c01$7752a0b0$034d210a@sandos>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The r8169 gigabit ethernet card causes lockups on both 2.4.22 and
2.6.0-test9. The 2.4 problem was that it got "too much work at interrupt"
indefinitely, and never ending. Im guessing it does the same on 2.6.0-test9,
but I probably wont be able to test this.

---
John Bäckstrand 

