Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUBCW5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUBCW5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:57:35 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:52878 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266157AbUBCW5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:57:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Juergen Stuber <stuber@loria.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] 2.6.2-rc1-bk1 Synaptics touchpad on IBM T30 not detected
Date: Tue, 3 Feb 2004 17:57:26 -0500
User-Agent: KMail/1.5.4
References: <86u127khxf.fsf@loria.fr>
In-Reply-To: <86u127khxf.fsf@loria.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402031757.27269.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 February 2004 03:49 pm, Juergen Stuber wrote:
> eb  3 20:34:12 freitag kernel: i8042.c: Detected active multiplexing
> controller, rev 10.12. Feb  3 20:34:12 freitag kernel: serio: i8042
> AUX0 port at 0x60,0x64 irq 12 Feb  3 20:34:12 freitag kernel: serio:
> i8042 AUX1 port at 0x60,0x64 irq 12 Feb  3 20:34:12 freitag kernel:
> serio: i8042 AUX2 port at 0x60,0x64 irq 12 Feb  3 20:34:12 freitag
> kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12 Feb  3 20:34:12
> freitag kernel: serio: i8042 KBD port at 0x60,0x64 irq 1 Feb  3
> 20:34:12 freitag kernel: input: AT Translated Set 2 keyboard on
> isa0060/serio0
>
> and later, supposedly when psmouse is loaded, 4 times
>
> Feb  3 20:34:12 freitag kernel: atkbd.c: Unknown key released
> (translated set 2, code 0x7a on isa0060/serio0). Feb  3 20:34:12
> freitag kernel: atkbd.c: This is an XFree86 bug. It shouldn't access
> hardware directly.

As a workaround try booting with i8042.nomux kernel option. Also, could you
please #define DEBUG in drivers/input/serio/i8042.c and post your dmesg?

Thank you.

-- 
Dmitry
