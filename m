Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTJ0KhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 05:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTJ0KhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 05:37:19 -0500
Received: from tomteboda.mdh.se ([130.243.76.141]:49642 "EHLO tomteboda.mdh.se")
	by vger.kernel.org with ESMTP id S261539AbTJ0KhM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 05:37:12 -0500
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: "'Zwane Mwaikambo'" <zwane@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] R8169 on 2.6.0-test9
Date: Mon, 27 Oct 2003 11:37:00 +0100
Message-ID: <070c01c39c76$4579ccb0$034d210a@sandos>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.53.0310261954230.20169@montezuma.fsmlabs.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >The r8169 gigabit ethernet card causes lockups on both 2.4.22 and
>> 2.6.0-test9.
>> 
>> It does it even on 2.4.20 and using the 8139cp. Heres lspci -vvv, 
>> starting to wonder if this card is special/odd/unsupported or if its 
>> just this hardware not being happy.
>
>This is bug report is somewhat confusing, are you using r8169.c 
>(CONFIG_R8169)?

I have tried the r8169 driver on 2.4.22 and 2.6.0-test9, and r8139cp on
2.4.20. On 2.4.22, it printed "too much work at interrupt" forever after
3-60 seconds of connection to a lan. I commented the printk out, that didnt
help though. The behaviour is exactly the same on 2.6.0-test9 and 2.4.20, a
few seconds after "ifconfig eth1 up" the machine hangs, though on 2.4.20
atleast there was no printk message seen. ifconfig shows it does receive and
send a few packets before it hangs, atleast on 2.4.22. The 8169 cards have
been confirmed to be working, but not on this particular motherboard though.

---
John Bäckstrand

