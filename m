Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVH3KwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVH3KwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVH3KwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:52:16 -0400
Received: from web53602.mail.yahoo.com ([206.190.37.35]:55700 "HELO
	web53602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751361AbVH3KwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:52:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mdBenx1cuCFV8wHz18eKmiaKLSTESG9hCC1rLVnZfh2jqfoPRB6fwyAPPpp453vnuqb/oBHNw9fsWF89nh5CS9dN7xEpmv/GALY3zqXcHwJKU/LSH9xMZFpKeQOzR3hQ+3eolbYWvJbvlBRm6LrrYliiD0B54rnT2SmqJONSygg=  ;
Message-ID: <20050830105210.11849.qmail@web53602.mail.yahoo.com>
Date: Tue, 30 Aug 2005 20:52:09 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43143258.5080208@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you test the new skge driver instead? If that
> one is broken then we 

Tested , not broken, working now but the same problem,
that is if I reboot to winXP or 2.6.12, 2.6.11, the
NIC is unusaeble. In XP it always says link is down,
or media disconnected (from ipconfig command output in
XP)
is it because the firmware of NIC has changed or any
reason?


I noticed  warning messages only with 2.6.13 

PCI: Failed to allocate mem resource #10:2000000@0 for
0000:02:01.0

and modem device in 2.6.13 IRQ is disabled.

ACPI: PCI Interrupt Link [LKMO] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LKMO] ->
GSI 20 (level, low) -> IRQ
 17
ACPI: PCI interrupt for device 0000:00:06.1 disabled

not sure if it gives more information.

skge addr 0xfeaf8000 irq 19 chip Yukon-Lite rev 9
skge eth0: addr 00:11:d8:f2:1f:18
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] ->
GSI 18 (level, low) -> IRQ
 16
Yenta: CardBus bridge found at 0000:02:01.0
[1043:1987]
skge eth0: enabling interface

skge eth0: Link is up at 10 Mbps, half duplex, flow
control none

Not sure how can I restore this thing back to normal
(sigh)

Thanks

> probably have more chance of getting it fixed :)
> 
> Thanks,
> Daniel
> 


S.KIEU

Send instant messages to your online friends http://au.messenger.yahoo.com 
