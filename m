Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281042AbRKKMYu>; Sun, 11 Nov 2001 07:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281044AbRKKMYk>; Sun, 11 Nov 2001 07:24:40 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35078 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281042AbRKKMY0>; Sun, 11 Nov 2001 07:24:26 -0500
Message-ID: <3BEE7A34.BF9526FB@evision-ventures.com>
Date: Sun, 11 Nov 2001 14:16:36 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161SuY-000498-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > With the following options enabled we get:
> > -freg-struct-return -mrtd -mregparm=3
> >
> >    text    data     bss     dec     hex filename
> > 1302372  260804  288080 1851256  1c3f78 vmlinux
> >
> > Quite significant difference if you ask me!!!
> 
> 30K is nice have but still a scratch on the surface compared with 500K 8)
> 
> > in a saving of about 2.3% in code size. This may not sound grat in
> > relative
> > numbers, but for a compiler designer this would already sound hilarious
> > and in
> > absolute numbers it's: 29760 bytes. Not withstanding the speed
> > improvement...
> 
> The obvious question is - have you tried running the kernel built like that
> with any asm fixups needed ?

I have now a nice kernel at home, compiled with -mredparm=3 up
and going. Full interactive session, full kernel compiles working,
X11 whatsup. Everything seems fine so far.

However I still have to build a RPM-feature grade kernel and test it.
Further the precise benchmarking will take some time as well.
I think that I will in esp. use the byte benchmark, since it is 
quite "kernel intensive" at some parts. Patch will follow on
monday (if nothing comes in between...).
