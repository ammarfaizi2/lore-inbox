Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUAKSrk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUAKSq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:46:58 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:36978 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265947AbUAKSqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:46:09 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Date: Sun, 11 Jan 2004 15:45:59 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401111545.59290.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


15:34:36 [root@murilo:/MRX/drivers]#diff -urN linux-2.6.0/drivers/input/keyboard/atkbd.c linux-2.6.1/drivers/input/keyboard/atkbd.c > test.diff
15:35:12 [root@murilo:/MRX/drivers]#wc -l test.diff
    387 test.diff
-------------> May be wrong?!

15:30:13 [root@murilo:/MRX/drivers]#dmesg | grep serio
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
----------> Last two lines, is apper each startx startup!!!!

 
