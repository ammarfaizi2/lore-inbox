Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKKBXT>; Fri, 10 Nov 2000 20:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQKKBXL>; Fri, 10 Nov 2000 20:23:11 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:27639 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129121AbQKKBXB>; Fri, 10 Nov 2000 20:23:01 -0500
Date: Sat, 11 Nov 2000 02:22:55 +0100
From: David Weinehall <tao@acc.umu.se>
To: root <whtdrgn@mail.cannet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 wont compile on AMD k6@-550
Message-ID: <20001111022255.C27400@khan.acc.umu.se>
In-Reply-To: <3A0C9B74.114053B6@cannet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A0C9B74.114053B6@cannet.com>; from whtdrgn@mail.cannet.com on Fri, Nov 10, 2000 at 08:05:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 08:05:56PM -0500, root wrote:
> Hello kernel hackers,
> 
>     I am having problems with compiling a kernel on an AMD K62-550.
> I am running Red Hat 6.2, and am getting error messages like this:
> 
> cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce
> -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c
> -o tcp_output.o tcp_output.c
> cc: Internal compiler error: program cc1 got fatal signal 11
> make[3]: *** [tcp_output.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/net/ipv4'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux/net/ipv4'
> make[1]: *** [_subdir_ipv4] Error 2
> make[1]: Leaving directory `/usr/src/linux/net'
> make: *** [_dir_net] Error 2

sig11 is typical for overclocking. If this is the case, try using the
factory setting. I know there are 550 MHz K6-2's nowadays, but you may
not have enough cooling to support it. If it still bugs at a lower
clock-rate, feel free to send in another bug-report.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
