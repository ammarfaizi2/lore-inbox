Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTAPVA1>; Thu, 16 Jan 2003 16:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTAPVA0>; Thu, 16 Jan 2003 16:00:26 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:45488 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267278AbTAPU7q>; Thu, 16 Jan 2003 15:59:46 -0500
Message-Id: <200301162108.WAA22987@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: radeonfb almost there.. but not quite! :)
To: Alessandro Suardi <alessandro.suardi@oracle.com>,
       "Paulo Andre'" <fscked@netvisao.pt>, linux-kernel@vger.kernel.org
Date: Thu, 16 Jan 2003 22:07:40 +0100
References: <20030115182012$25b7@gated-at.bofh.it> <20030116134006$783d@gated-at.bofh.it>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:

> 
> Radeonfb works better for me in 2.5.58, same card but on a
>   Dell Latitude C640 - 1024x768 though, and xclk=16600.
> 
> I say "better" and not simply "works" because
> 
>   - the gpm cursor positioned on characters shows different ones
>      (eg. hovering on a 'd' it shows a highlighted 'B')
This works for me.

>   - the pre-penguin display is garbage. The console though gets
>      to recover right after the penguin display
Same here. I see the same garbage when switching resolutions 
with fbset.

I also have a small problem when switching to and from X. Most of 
the time everything is fine, but sometimes it is unreadable and
I have to switch back and forth again.

This is on an IBM Thinkpad A30p with 1600x1200 local display.
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
radeonfb: probed DDR SGRAM 32768k videoram
radeon_get_moninfo: bios 4 scratch = 1000004
radeonfb: panel ID string: 1600x1200
radeonfb: detected DFP panel size from BIOS: 1600x1200
radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END

