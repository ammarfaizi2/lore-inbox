Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130690AbRAFBNX>; Fri, 5 Jan 2001 20:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132263AbRAFBNP>; Fri, 5 Jan 2001 20:13:15 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:17934 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S130690AbRAFBNH>; Fri, 5 Jan 2001 20:13:07 -0500
Date: Sat, 6 Jan 2001 12:12:44 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matthew Schumacher <schu@schu.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is
 selected
In-Reply-To: <3A56653C.BF55B6E0@schu.net>
Message-ID: <Pine.LNX.4.31.0101061156360.15856-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Matthew Schumacher wrote:

>
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.0/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.0/include/linux/modversions.h   -c -o ip_nat_ftp.o
> ip_nat_ftp.c
> ip_nat_ftp.c: In function `help':
> ip_nat_ftp.c:315: structure has no member named `nat'
> make[2]: *** [ip_nat_ftp.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.0/net/ipv4/netfilter'
> make[1]: *** [_modsubdir_ipv4/netfilter] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.0/net'
> make: *** [_mod_net] Error 2
>
> This is the error I get if I try to compile in the kernel or as a
> module.
>

Did you configure the kernel with 'Full NAT'?

(CONFIG_IP_NF_NAT in the .config file).

- James
--
James Morris
<jmorris@intercode.com.au>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
