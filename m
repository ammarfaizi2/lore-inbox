Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSGUAoH>; Sat, 20 Jul 2002 20:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGUAoH>; Sat, 20 Jul 2002 20:44:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:52235 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317611AbSGUAoF>; Sat, 20 Jul 2002 20:44:05 -0400
Date: Sat, 20 Jul 2002 21:47:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.27 -- memory.c:50:22: asm/rmap.h: No such file or directory
In-Reply-To: <1027211680.1863.28.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L.0207202146360.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jul 2002, Miles Lane wrote:

> Hmm.  This problem looks pretty straightforward.

Indeed.  Have you tried 'make oldconfig' to set the
symlink in include/ ?

> find . -name "*.h" | xargs grep rmap.h
>
> ./include/asm-generic/rmap.h: * linux/include/asm-generic/rmap.h
> ./include/asm-i386/rmap.h:#include <asm-generic/rmap.h>
>
> find . -name "*.c" | xargs grep rmap.h
>
> ./mm/memory.c:#include <asm/rmap.h>
> ./mm/rmap.c:#include <asm/rmap.h>


Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

