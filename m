Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263619AbTCUOEQ>; Fri, 21 Mar 2003 09:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263621AbTCUOEQ>; Fri, 21 Mar 2003 09:04:16 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:38325 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263619AbTCUOEP>; Fri, 21 Mar 2003 09:04:15 -0500
Message-ID: <20030321141454.18751.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: alexh@ihatent.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 21 Mar 2003 15:14:54 +0100
Subject: Re: 2.5.65-mm3
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Alexander Hoogerhuis <alexh@ihatent.com> 
Date: 	21 Mar 2003 11:58:18 +0100 
To: Andrew Morton <akpm@digeo.com> 
Subject: Re: 2.5.65-mm3 
 
> Andrew Morton <akpm@digeo.com> writes: 
> > 
> > [SNIP] 
> > 
>  
>   gcc -Wp,-MD,net/ipv4/netfilter/.ip_conntrack_core.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 
-Iinclude/asm-i386/mach-default 
> -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ip_conntrack_core  -c -o 
net/ipv4/netfilter/.tmp_ip_conntrack_core.o net/ipv4/netfilter/ip_conntrack_core.c 
> net/ipv4/netfilter/ip_conntrack_core.c: In function `remove_expectations': 
> net/ipv4/netfilter/ip_conntrack_core.c:276: invalid suffix on integer constant 
> net/ipv4/netfilter/ip_conntrack_core.c:276: called object is not a function 
> make[4]: *** [net/ipv4/netfilter/ip_conntrack_core.o] Error 1 
> make[3]: *** [net/ipv4/netfilter] Error 2 
> make[2]: *** [net/ipv4] Error 2 
> make[1]: *** [net] Error 2 
> make: *** [modules] Error 2 
>  
 
Edit line 276 of net/ipv4/netfilter/ip_conntrack_core and simply 
remove the '3D' sequence of characters after the equal (=) 
sign. 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
