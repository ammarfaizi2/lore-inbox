Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSFEKpc>; Wed, 5 Jun 2002 06:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSFEKpb>; Wed, 5 Jun 2002 06:45:31 -0400
Received: from port-213-20-228-67.reverse.qdsl-home.de ([213.20.228.67]:40207
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S315239AbSFEKpa> convert rfc822-to-8bit; Wed, 5 Jun 2002 06:45:30 -0400
Date: Wed, 05 Jun 2002 12:44:24 +0200 (CEST)
Message-Id: <20020605.124424.607955686.rene.rebe@gmx.net>
To: rabbit@rabbit.online.bg
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd k6-3 L3 cache 
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20020605044616.GA3297@rabbit.online.bg>
X-Mailer: Mew version 2.2 on XEmacs 21.4.7 (Economic Science)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On: Tue, 4 Jun 2002 23:46:16 -0500,
    Peter Rabbitson <rabbit@rabbit.online.bg> wrote:
> Hi everyone. I have a question regarding hardware caches. When I compile the
> kernel on k6/2 cpu I get messages identifying L1 cache of 64k and L2 cache of
> 1024k which are the actual hardware amounts. But kernel on a k6/3+ cpu gives
> out this:
> -------
> CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
> CPU: L2 Cache: 256K (32 bytes/line)
> CPU: After vendor init, caps: 008021bf c08029bf 00000000 00000002
> CPU:     After generic, caps: 008021bf c08029bf 00000000 00000002
> CPU:             Common caps: 008021bf c08029bf 00000000 00000002
> ------

This are the correct values - I do not know why a K6/2 kernel reports
bogus ones.

The caches (incl. the L3 cache on the mainboard) are used by the
silicon logic in you CPU and chipset automatically - no OS or BIOS
support is needed for this.

> Does this mean that I am actually loosing the benefit of having 1m of cache 
> on the motherboard (in this case L3)? Or the kernel still uses transparrent
> bios routines and stores data in L3? Or maybe such cpus shopuld run kernel
> compiled for k7/athlon cpus? I would appreciate any comments or suggestions,
> nevertheless I am more than non-proficient in programming. Just a curious
> cat in the linux community :)
> 
> Peter

k33p h4ck1n6
  René

--  
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)
e-mail:   rene.rebe@gmx.net, rene@rocklinux.org
web:      www.rocklinux.org, drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
