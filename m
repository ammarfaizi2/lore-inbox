Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbTGAHQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbTGAHQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:16:24 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([24.192.190.108]:6660
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S266023AbTGAHQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:16:12 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Adam Belay" <ambx1@neo.rr.com>
Subject: Re: simple pnp bios io resources bug makes  system unusable
Date: Tue, 1 Jul 2003 03:30:40 -0400
Message-ID: <000001c33fa2$ae2a85a0$030aa8c0@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I also ran into this problem, Adam is was also working on a fix
although I wonder if it's the same fix?

Shawn S.

>List:     linux-kernel
>Subject:  simple pnp bios io resources bug makes  system unusable
>From:     CarlosRomero <caberome () bellsouth ! net>
>Date:     2003-07-01 3:38:17

>cat /sys/devices/pnp0/00\:0c/name
>Reserved Motherboard Resources

>cat /sys/devices/pnp0/00\:0c/resources
>state = active
>io 0x4d0-0x4d1
>io 0xcf8-0xcff
>io 0x3f7-0x3f7
>io 0x401-0x407
>io 0x298-0x298
>io 0x00000000-0xffffffff
>mem 0xfffe0000-0xffffffff
>mem 0x100000-0x7ffffff

>fixup: check for null io base, other devices are now able to initialize.


