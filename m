Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285724AbRL3X47>; Sun, 30 Dec 2001 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285745AbRL3X4u>; Sun, 30 Dec 2001 18:56:50 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:8152 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S285724AbRL3X4g>;
	Sun, 30 Dec 2001 18:56:36 -0500
From: "Jean-Francois De Rudder" <j.derudder@btinternet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel panic from usb-ohci
Date: Sun, 30 Dec 2001 23:56:33 -0000
Message-ID: <000f01c1918d$9d921f60$0100a8c0@JFDDESKTOP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if I am at the wrong place, thought a kernel panic would
justify the message.

Got this kernel bug on Mandrake 8.1 installing a Speedtouch ADSL modem
(USB). Unfortunately, I cannot copy and paste the content of the error
as as get a kernel panic straight away and the PC has'nt got kbd/mouse.

Basically everything works fine until I start running the modem_run
command, the pppd daemon and finally my iptables script. I get a
connection for anything from 1 to 5 minutes, which then results in the
following output:

usb-ohci.c : bus 00:0c.0 devnum 2 deletion in interrupt
Kernel BUG at usb_ohci.c: 886!
Invalid operand: 0000
CPU: 0
EIP: 0010 [<c8851de8>]
EFLAGS: 00010082

I stopped writing down all the values at this stage... I can supply them
if anybody needs them for further analysis...

I am running on an old Pentium 133 (Internet Gateway PC) with a DLINK
USB card (added on as no USB initially on PC) 

Thanks a lot!
Jean.

