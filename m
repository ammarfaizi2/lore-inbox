Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263439AbTC2RAx>; Sat, 29 Mar 2003 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263447AbTC2RAx>; Sat, 29 Mar 2003 12:00:53 -0500
Received: from mmp11.dna044.com ([217.78.194.33]:30080 "EHLO
	mgmtmmp11.dnafinland.fi") by vger.kernel.org with ESMTP
	id <S263439AbTC2RAw>; Sat, 29 Mar 2003 12:00:52 -0500
Date: Sat, 29 Mar 2003 19:12:25 +0200
From: Thomas Backlund <tmb@iki.fi>
Subject: Re: 3c59x gives HWaddr FF:FF:...
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Message-id: <0d0001c2f616$6a678dc0$9b1810ac@xpgf4>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <20030328145159.GA4265@werewolf.able.es>
 <20030328124832.44243f83.akpm@digeo.com>
 <20030328230510.GA5124@werewolf.able.es>
 <20030328151624.67a3c8c5.akpm@digeo.com>
 <20030329004630.GA2480@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "J.A. Magallon" <jamagallon@able.es>
|
| So, 3 options:
| - the 905C goes to trashcan
| - the driver fails to initialize something (I dont trust this...)
| - winblows messed the card eeprom...any way to tidy it up again ?
|
| Thanks everybody...
|
| --
| J.A. Magallon <jamagallon@able.es>      \                 Software is
like sex:
| werewolf.able.es                         \           It's better when
it's free
| Mandrake Linux release 9.1 (Bamboo) for i586
| Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

Since you have MDK 9.1, could you try the 3rdparty/3c90x module from
mdk kernel-source and see if it works...
It is 3Com's own driver... that is supposed to work with that card...

If it won't work, maybe it's the card that is broken... messed up...
If it works, the bug is in the 3c59x module...

Thomas


