Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266070AbRGCBPb>; Mon, 2 Jul 2001 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266080AbRGCBPV>; Mon, 2 Jul 2001 21:15:21 -0400
Received: from operamail.com ([199.29.68.126]:14348 "EHLO operamail.com")
	by vger.kernel.org with ESMTP id <S266070AbRGCBPL>;
	Mon, 2 Jul 2001 21:15:11 -0400
X-WM-Posted-At: operamail.com; Mon, 2 Jul 01 21:14:37 -0400
X-WebMail-UserID: mrsamjooky
Date: Mon, 2 Jul 2001 21:14:37 -0400
From: mr sam jooky <mrsamjooky@operamail.com>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00000000
Subject: re: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
Message-ID: <3B448CA1@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: InterChange (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Somewhere between 2.4.2 and 2.4.5-ac13, PCMCIA card insertion and
>removal appears to have broken on my Toshiba Libretto. On 2.4.2 all was
>fine. On both 2.4.5-ac13 and ac22 it's broken. The whole machine
>freezes
>solid, no SAK-s, SAK-u, SAK-b, no Ctrl-Alt-Fn to switch VC's. No
>messages
>are issued. Problem occurs when inserting/removing any of YE-Data
>PCMCIA
>floppy, TDK Smartmedia adapter (ide_cs), or 3c589 ethernet card.

On my IBM Thinkpad 390E my PCMCIA works fine with 2.4.5, on very rare 
occasions
the mouse will drift diagonaly to the lower right corner. I read in the kernel
sources that this happens normaly due to probing of the PCMCIA which screws up
the mouse device. It happens so rarely I have not yet taken the time to try to
debug it.

