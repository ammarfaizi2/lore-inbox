Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316721AbSFDUQ4>; Tue, 4 Jun 2002 16:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSFDUQz>; Tue, 4 Jun 2002 16:16:55 -0400
Received: from www.transvirtual.com ([206.14.214.140]:12037 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316712AbSFDUQy>; Tue, 4 Jun 2002 16:16:54 -0400
Date: Tue, 4 Jun 2002 13:16:49 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 -- Hanging (no oops and sysrq fails) after switching to
 rivafb
In-Reply-To: <1023175418.7859.32.camel@agate>
Message-ID: <Pine.LNX.4.44.0206041314110.1200-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I tried booting both with acpi enabled and with pci=noacpi set.
> When the machine freezes, the VT display mode has just switched
> to using rivafb (video=riva:1600x1200-16).

I plan to port this driver next over to the new api. I planned on doing it
today except Linus BK tree will not compile right now :-( I get a

/usr/include/asm/eerno.h:4: asm-generic/errno.h: No such file or directory
make[1]: *** [split-include] Error 1

Once this is fixed I will get to fixing the NVIDIA fbdev driver.


