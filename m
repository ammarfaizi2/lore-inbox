Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbRBZPml>; Mon, 26 Feb 2001 10:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbRBZPme>; Mon, 26 Feb 2001 10:42:34 -0500
Received: from web11205.mail.yahoo.com ([216.136.131.187]:35085 "HELO
	web11205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130237AbRBZPm3>; Mon, 26 Feb 2001 10:42:29 -0500
Message-ID: <20010226154228.48338.qmail@web11205.mail.yahoo.com>
Date: Mon, 26 Feb 2001 07:42:28 -0800 (PST)
From: Stephen Mollett <molletts@yahoo.com>
Subject: "io mapaddr 0xXXXXX not valid" in smc-mca in 2.4.x
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel version 2.4.x (x from 0 to 2-ac3), the
smc-mca driver gives many errors like the following on
the console log:

io mapaddr 0xXXXXX not valid at smc-mca.c:YYY!

where XXXXX is an address within the shared-memory
assigned to the adapter card, and YYY is 378, 398 or
408.

I have tested the driver on two IBM MCA systems - a
9577 and an 8590. I have tried three different network
adapters in each machine:

WD Ethercard PLUS 10T/A (WD8003W/A)
SMC Ethercard PLUS Elite/A BNC/AUI (WD8013EP/A)
SMC Ethercard PLUS Elite/A UTP/AUI (WD8013WP/A)

All the adapters give the errors, in both machines.
All adapters and both PS/2s are known to be good with
kernel 2.2.17.

* please cc any responses to me <molletts@yahoo.com>
as I do not subscribe to the list.

Regards,
Stephen Mollett

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
