Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRKGNgv>; Wed, 7 Nov 2001 08:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280789AbRKGNgl>; Wed, 7 Nov 2001 08:36:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64018 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280787AbRKGNgY>; Wed, 7 Nov 2001 08:36:24 -0500
Subject: Re: Using %cr2 to reference "current"
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 7 Nov 2001 13:38:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BE93E77.6E4E3C95@evision-ventures.com> from "Martin Dalecki" at Nov 07, 2001 03:00:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161SuY-000498-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With the following options enabled we get:
> -freg-struct-return -mrtd -mregparm=3
> 
>    text    data     bss     dec     hex filename
> 1302372  260804  288080 1851256  1c3f78 vmlinux
> 
> Quite significant difference if you ask me!!!

30K is nice have but still a scratch on the surface compared with 500K 8)

> in a saving of about 2.3% in code size. This may not sound grat in
> relative
> numbers, but for a compiler designer this would already sound hilarious
> and in
> absolute numbers it's: 29760 bytes. Not withstanding the speed
> improvement...

The obvious question is - have you tried running the kernel built like that
with any asm fixups needed ?
