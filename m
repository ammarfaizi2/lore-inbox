Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSGSOju>; Fri, 19 Jul 2002 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSGSOjt>; Fri, 19 Jul 2002 10:39:49 -0400
Received: from web13104.mail.yahoo.com ([216.136.174.149]:19470 "HELO
	web13104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315260AbSGSOjt>; Fri, 19 Jul 2002 10:39:49 -0400
Message-ID: <20020719144251.70711.qmail@web13104.mail.yahoo.com>
Date: Fri, 19 Jul 2002 16:42:51 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re:linux-2.4.19-rc2aa1 (RH7.2 kgcc: Internal compiler error in function add_pending_init)
To: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Cc: s_sokolov@avtodor.gorny.ru
In-Reply-To: <20020719032653.96817.qmail@web9207.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Alex Davis <alex14641@yahoo.com> a écrit : > The
only time this ever happened to me, it turned
> out one of my 
> RAM sticks had failed. Just out of curiosity, have
> you had any 
> oopses recently?
> 
> Hi All !!
> When I try compile kernel on my RH7.2
> with CC=kgcc, I receive this message:
> 
> kgcc  -D__ASSEMBLY__ -D__KERNEL__
> -I/usr/src/linux-2.4.19-rc2aa1/include -traditional
> \
> -c head.S -o head.o kgcc  -D__KERNEL__
> -I/usr/src/linux-2.4.19-rc2aa1/include -Wall \
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-st
> rict-aliasing -fno-common \
> -fomit-frame-pointer -pipe  -march=i686   -nostdinc

-march=i686 ??????
on egcs-2.91.66 ?
strange 



> -I /usr/lib/gcc-lib/i386-redhat- \
> linux/egcs-2.91.66/include
> -DKBUILD_BASENAME=init_task  -c -o init_task.o
> init_task.c \
> ../../gcc/c-typeck.c:5945: Internal compiler error
> in function add_pending_init \
> make[1]: *** [init_task.o] Error 1 make[1]: Leaving
> directory \
>                
> `/usr/src/linux-2.4.19-rc2aa1/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Autos - Get free new car price quotes
> http://autos.yahoo.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

=====
--
The UNIX Hierarchy - Beginner
- insecure with the concept of a terminal 
- has yet to learn the basics of "vi" 
- has not figured out how to get a directory 
- still has trouble with typing <RETURN> after each line of input

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
