Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbRDDTKH>; Wed, 4 Apr 2001 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRDDTJ5>; Wed, 4 Apr 2001 15:09:57 -0400
Received: from dial127.za.nextra.sk ([195.168.64.127]:1028 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S131882AbRDDTJn>;
	Wed, 4 Apr 2001 15:09:43 -0400
Date: Wed, 4 Apr 2001 19:21:04 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling problem kernel 2.4.2
Message-ID: <20010404192104.A6914@Boris>
In-Reply-To: <5.0.2.1.2.20010326175151.01eef100@pop.wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010326175151.01eef100@pop.wanadoo.nl>; from tscholte@wanadoo.nl on Mon, Mar 26, 2001 at 06:00:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -02
> -fomit-frame-pointer -fno-strict-aliasing -pipe -march=i486  -c -o init/main.o
> init/main.c
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -02
> fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i486
> -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
> cpp: /usr/src/linux/include/linux/compile.h: Input/output error
> init/version.c:20: `UTS_VERSION' undeclared here (not in a function)
> init/version.c:20: initializer element for `system_utsname.version' is not
> constant
> init/version.c:25: parse error before `LINUX_COMPILE_BY'
> make: *** [init/version.o] Error 1

Hi.

-02 mean -O2 ?

Do you comile over NFS ? Did you try it to local-compile , or compile
on another system version ? It really
may be nfs or some system bug, if you compile on some old system (what kernel
version did you compile on ? They me differ on slack and redhat machines.)

I recently had a bug with gnu assembler, which could safely compile all
files a tried, but not the ones that consisted of any combination 
3 chars name+1 char suffix.
Really interesting bug too.

Bye                                                                   B.

