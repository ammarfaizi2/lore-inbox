Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272333AbTHILjC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272335AbTHILjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:39:02 -0400
Received: from teheran.magic.fr ([62.210.158.46]:29651 "EHLO teheran.magic.fr")
	by vger.kernel.org with ESMTP id S272333AbTHILjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:39:00 -0400
Subject: Re: 2.6.0-test2 does not boot with matroxfb
From: Jocelyn Mayer <l_indien@magic.fr>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-9
Organization: 
Message-Id: <1060429216.29152.61.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Aug 2003 13:40:16 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On  8 Aug 03 at 17:45, Juergen Rose wrote:
> ý I tried on my PC with a Matrox-G450 several kernel and boot options.
> ý Every time when the console should work with matrox framebuffer,
> linux
> ý was crashed. With 2.6.0-test2 and 2.6.0-test2-bk7 I had the
> following
> ý warning performing ''make modules_install''
> ý WARNING:
> ý
> /lib/modules/2.6.0-test2[-bk7]/kernel/drivers/video/matrox/matroxfb_crtc2.ko
> ý needs unknown symbol matroxfb_enable_irq This WARNING disapears for
> 
> I'm not able to get through Linus's mail filters for past three weeks.

I can boot a Athlon based PC with a Matrox-G450. It runs well.
The frame buffer is broken, and so is X and overlay buffer,
but it doesn't crash at all.
I also booted another kernel on the VGA console.
The console is OK, X and overlay buffer are still broken,
but the machine euns well.
I have two 2.6.0-test2, one with the matroxfb,
the other one just with the VGA console.

> 
> You can also try <a
> href="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz">ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz</a>
> (if 2.6.0-test2-mm5 does not complain about unexported matrox_*_irq
> it will probably not apply cleanly to it). It restores fbcon subsystem
> to the 2.4.x's version.
>                                             Petr

I will check this, I'd like to have more than a VGA console :-)


-- 
Jocelyn Mayer <l_indien@magic.fr>

