Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263991AbUDFUU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbUDFUU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:20:58 -0400
Received: from mail.daybyday.de ([213.191.85.38]:1779 "EHLO data.daybyday.de")
	by vger.kernel.org with ESMTP id S263991AbUDFUU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:20:56 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <3B75AEAB-8807-11D8-A1B6-000393C43976@postmail.ch>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Stefan Wanner <stefan.wanner@postmail.ch>
Subject: 2.6.5-rc3: Parse error in traps.c on Alpha
Date: Tue, 6 Apr 2004 22:16:05 +0200
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still have this problem in 2.6.5

> From: Stefan Wanner <stefan.wanner@postmail.ch>
> Date: 3. April 2004 10:53:11 GMT+02:00
> To: linux-alpha@vger.kernel.org, rth@kanga.twiddle.home
> Subject: 2.6.5-rc3: traps.c does not compile anymore
>
> Hello
>
> Upgrading from 2.6.4 to 2.6.5-rc3, arch/alpha/kernel/traps.c does not 
> compile anymore. What's wrong?
>
> alpha:~/src/linux-2.6.5-rc3# make
> make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-alpha/asm_offsets.h
>   CHK     include/linux/compile.h
>   CC      arch/alpha/kernel/traps.o
> arch/alpha/kernel/traps.c: In function `opDEC_check':
> arch/alpha/kernel/traps.c:55: parse error before `['
> make[1]: *** [arch/alpha/kernel/traps.o] Error 1
> make: *** [arch/alpha/kernel] Error 2
> alpha:~/src/linux-2.6.5-rc3#
>
>
>
> Regards
> Stefan
>
>
>
> alpha:~# gcc -v
> Reading specs from /usr/lib/gcc-lib/alpha-linux/2.95.4/specs
> gcc version 2.95.4 20011002 (Debian prerelease)
> alpha:~# ld -v
> GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
>

