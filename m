Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTESKJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTESKJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:09:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:42973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262328AbTESKJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:09:15 -0400
Date: Mon, 19 May 2003 12:22:07 +0200 (MEST)
From: S-n-e-a-k-e-r@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: int 0x15, ah=0x88 question
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0006823522@gmx.net
X-Authenticated-IP: [193.171.252.134]
Message-ID: <9188.1053339727@www54.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Following code comes from arch/i386/boot/setup.S (memory detection):

387         movb    $0x88, %ah
388         int     $0x15
389         movw    %ax, (2)

Why memory address 2 is used? Where else in the kernel is it used? We are in
real mode, so (2) should be the same as %ds:(2), or not?

Sorry that I'm bugging the mailing list with that question but I didn't
found the answer anywhere. So a web page, a book or something else would be also
nice as an answer.

Regards,

Andy

Ps: please cc me!

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

