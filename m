Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274176AbRIXVyR>; Mon, 24 Sep 2001 17:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274170AbRIXVyH>; Mon, 24 Sep 2001 17:54:07 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:9491 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274165AbRIXVxy>; Mon, 24 Sep 2001 17:53:54 -0400
X-Apparently-From: <mlrecv@yahoo.com>
Reply-To: <mlrecv@yahoo.com>
From: "Zhifeng F. Chen" <mlrecv@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Subject: HIGHMEM problem.
Date: Mon, 24 Sep 2001 17:54:18 -0400
Message-ID: <CNEAKFLBCODPEFGEGALPKECKCEAA.mlrecv@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I am using a Emulex's cLAN 1000 adapter in some machines. And with much
effort and help, I coud finally make the clan-2.0.x driver work under kernel
2.4.9 (and 2.4.10). However, I found if I turn "High Memory Support" off,
the kernel only report 896M through /proc/meminfo, but clan can work well.
On the other hand, if I turn "High Memory Support" to 4G or 64G, the kernel
can report the memory correctly, but clan gets "RX Async interrupt: vi 0,
error 010000" error (2.4.9) or clan gets "fatal (PCI?) error (status 2200)
result 0".

    I don't know if it's the problem of the kernel or the driver. And
without Highmem support, is that 128M memory really wasted? Or,  are they
just used by kernel and can't be used by user?

Sincerely
ZF


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

