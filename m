Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSG2J1V>; Mon, 29 Jul 2002 05:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSG2J1V>; Mon, 29 Jul 2002 05:27:21 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:11756 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314096AbSG2J1U> convert rfc822-to-8bit; Mon, 29 Jul 2002 05:27:20 -0400
MIME-Version: 1.0
Subject: usb-core/uhci - scp problem
From: d.e.jung-ludwigshafen@t-online.de (Dr. Dietmar Jung)
Reply-To: <0621665841-0001@T-Online.de>
To: <linux-kernel@vger.kernel.org>
X-Mailer: T-Online eMail 4.104
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: 29 Jul 2002 09:29 GMT
Message-ID: <17Z6r9-1mkrJYC@fwd09.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a Laptop Gericom 1.st Supersonic 
Processot PIII 1000 MHz
256 MB RAM
30 GB HD
2 USB 1.1 
2 PCMCIA (1) eg. 1 PCMCIA (2)

with Linux SuSE 7.3
Kernel 2.4.10-GB (SuSE)

I have 

1 USB Mouse
and
1 Maxtor 40 GB Personal Storage 3000 LE USB 2.0
1 Partition ext2,
with uhci and usb-storage drivers for the HD.

Everything works fine.
scp works fine when the external HD is not mounted.

But, when trying to use scp over PCMCIA Gericom 10/100 Card with the external HD mounted,(writing to the internal or the external HD, working in an X-console or working console without any X) the console used will hang itself up. 

Neither the console nor scp nor the mounts can be killed by kill -9 *. 

You can lock and lockout on other consoles/terminals.

Shutdown -h now does not give any comments, but does not shut the system down. You have to cut the power off.

Used seperately the interrupts used by the PCMCIA-card and the external HD differ. That is not the cause.

Is there an explanation? Can anything be done about it.

d.e.jung-ludwigshafen@t-online.de

Best regards

Dietmar Jung

