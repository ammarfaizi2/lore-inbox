Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUBORik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 12:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBORik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 12:38:40 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:23709 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265155AbUBORih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 12:38:37 -0500
Date: Sun, 15 Feb 2004 18:38:36 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Cross Compiling
Message-ID: <20040215173835.GA22567@MAIL.13thfloor.at>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20040213205743.GA30245@MAIL.13thfloor.at.suse.lists.linux.kernel> <p73n07my8nn.fsf@verdi.suse.de> <20040213234554.GA32440@MAIL.13thfloor.at> <Pine.GSO.4.58.0402151214520.22078@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402151214520.22078@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 12:16:10PM +0100, Geert Uytterhoeven wrote:
> On Sat, 14 Feb 2004, Herbert Poetzl wrote:
> >   linux-2.4.25-rc2        config  dep     kernel  modules
> >   m68k/m68k:              OK      OK      OK      OK
> 
> Good! :-)

yeah but,

			2.6.2-rc3       2.6.3-rc2
[ARCH m68k/m68k]        failed.         failed.       

Bad! :(

> 
> One related question: anyone who knows how to run a cross-depmod, 
> so I can find missing symbol exports without running depmod 
> on the target?

../modutils-2.4.26/configure --target=m68k-linux

seems to do something, so it might even work ...

depmod: ELF file /lib/.../kernel/crypto/aes.o not for this architecture
depmod: ELF file /lib/.../kernel/crypto/blowfish.o not for this architecture

HTH,
Herbert

> Gr{oetje,eeting}s,
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
