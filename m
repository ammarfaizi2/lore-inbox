Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSLMIu4>; Fri, 13 Dec 2002 03:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSLMIu4>; Fri, 13 Dec 2002 03:50:56 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:39418 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261640AbSLMIuz>;
	Fri, 13 Dec 2002 03:50:55 -0500
Date: Fri, 13 Dec 2002 09:53:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>,
       James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: atyfb in 2.5.51
In-Reply-To: <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0212130949450.6939-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2002, Alan Cox wrote:
> On Wed, 2002-12-11 at 20:43, David S. Miller wrote:
> > fbdev is nice, in the specific cases where the device fits the fbdev
> > model, because once you have the kernel bits you have X support :)
> 
> fbdev also can't be used in some situations on x86. Deeply fascinating
> things happen on some x86 processors if you execute a loop of code with
> an instruction that crosses two different memory types.

Do you mean one load/store access to memory where the first and the last part
(e.g. first 2 and last 2 bytes for a 32-bit word) are to different memory types
(e.g. main RAM and video RAM on PCI)? If yes, where does that happen? If no,
can you please clarify?

(At first I thought you meant an instruction where the opcode crosses those
 two memory types, but we don't put code in video RAM...)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

