Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293100AbSBWFnz>; Sat, 23 Feb 2002 00:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293101AbSBWFnp>; Sat, 23 Feb 2002 00:43:45 -0500
Received: from [211.99.239.78] ([211.99.239.78]:37767 "HELO happy")
	by vger.kernel.org with SMTP id <S293100AbSBWFnb>;
	Sat, 23 Feb 2002 00:43:31 -0500
Date: Sat, 23 Feb 2002 13:40:53 +0800
From: hugang <gang_hu@soul.com.cn>
To: Justin Piszcz <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-Id: <20020223134053.4fbe25ed.gang_hu@soul.com.cn>
In-Reply-To: <3C771D29.942A07C2@starband.net>
In-Reply-To: <3C771D29.942A07C2@starband.net>
Organization: soul
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 23:40:09 -0500
Justin Piszcz <war@starband.net> wrote:

> Wow, not sure if anyone here has done any benchmarks, but look at these
> build times:
> Kernel 2.4.17 did compile with 3.0.4, just much much slower than 2.95.3
> however.
> 
> GCC 2.95.3
> Boot sector 512 bytes.
> Setup is 2628 bytes.
> System is 899 kB
> make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
> 287.28user 23.99system 5:15.81elapsed 98%CPU (0avgtext+0avgdata
> 0maxresident)k
> 0inputs+0outputs (514864major+684661minor)pagefaults 0swaps
> 
> GCC 3.0.4
> Boot sector 512 bytes.
> Setup is 2628 bytes.
> System is 962 kB
> warning: kernel is too big for standalone boot from floppy
> make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
> 406.87user 28.38system 7:23.68elapsed 98%CPU (0avgtext+0avgdata
> 0maxresident)k
> 0inputs+0outputs (546562major+989237minor)pagefaults 0swaps
> 
Why the system size is different. Possble your use differ config.

-- 
thanks with regards!
hugang.บ๚ธี.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn
***********************************
