Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTJEMSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbTJEMSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:18:08 -0400
Received: from mail.g-housing.de ([62.75.136.201]:21890 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263088AbTJEMSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:18:06 -0400
Message-ID: <3F800BF8.3020800@g-house.de>
Date: Sun, 05 Oct 2003 14:18:00 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: de-de, de, en-gb, en-us, en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1066128091.d4fe@endorphin.org>
CC: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: crypto benchmark results with 2.6.0-test6
References: <20031004104131.GA1533@leto2.endorphin.org>
In-Reply-To: <20031004104131.GA1533@leto2.endorphin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, took me a while to retest.

Fruhwirth Clemens schrieb:
> Hi,
> 
> would you like to benchmark
> 
> http://clemens.endorphin.org/patches/aes-i586-asm-2.6.0-test5.diff

yes, i did so, results on:

http://www.nerdbynature.de/bench/prinz/

> and
> 
> http://clemens.endorphin.org/twofish-i586/ (experimential) 
> 
> too? :)

uh, i guess this masm/windoze/elf32 stuff is too much for me, i could 
try, but don't have time to dig into this. but you could try my script, 
and run benchmarks on your machine too.
but: how is this twofish optimization supposed to go into mainline 
anyway? one had to use a special compiling environment to compile a kernel?

i set up these benchmarks for me too, because i needed to know what 
cipher is fast enough for my own use. usually i sticked to serpent, now 
aes-i586 looks quite good on this PC. i wonder if it will compile and so 
something on ppc32 too, but probably not. which is a pity, because my 
primary use of the cryptoloop is a ppc :-(

Thank you,
Christian.

-- 
BOFH excuse #349:

Stray Alpha Particles from memory packaging caused Hard Memory Error on 
Server.

