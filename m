Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSBMQ2P>; Wed, 13 Feb 2002 11:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbSBMQ14>; Wed, 13 Feb 2002 11:27:56 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:12499 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S287596AbSBMQ1s>; Wed, 13 Feb 2002 11:27:48 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: <jss@pacbell.net>, "'Steve Kieu'" <haiquy@yahoo.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Unable to compile 2.5.4: "control reaches end of non-void functionm"
Date: Wed, 13 Feb 2002 16:27:41 -0000
Message-ID: <000601c1b4ab$5c0763c0$0100a8c0@stratus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <PGEMINDOPMDNMJINCKBNAEDCCBAA.jss@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

I get the same/similar issue:

[root@athena linux-2.5.4]# make install
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall
-Wstrict-prototypes -Wno-t
rigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mprefe
rred-stack-boundary=2 -march=i586   -DKBUILD_BASENAME=main -c -o
init/main.o ini
t/main.c
In file included from /usr/src/linux-2.5.4/include/asm/thread_info.h:13,
                 from
/usr/src/linux-2.5.4/include/linux/thread_info.h:10,
                 from /usr/src/linux-2.5.4/include/linux/spinlock.h:7,
                 from /usr/src/linux-2.5.4/include/linux/mmzone.h:8,
                 from /usr/src/linux-2.5.4/include/linux/gfp.h:4,
                 from /usr/src/linux-2.5.4/include/linux/slab.h:14,
                 from /usr/src/linux-2.5.4/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.5.4/include/asm/processor.h: In function
`thread_saved_pc':
/usr/src/linux-2.5.4/include/asm/processor.h:444: dereferencing pointer
to incom
plete type
/usr/src/linux-2.5.4/include/asm/processor.h:445: warning: control
reaches end o
f non-void function
make: *** [init/main.o] Error 1
[root@athena linux-2.5.4]#

____________________
Daniel J Blueman 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of J.S.S.
> Sent: 13 February 2002 13:54
> To: Steve Kieu
> Cc: linux-kernel
> Subject: RE: Unable to compile 2.5.4: "control reaches end of 
> non-void functionm"
> 
> 
> I have this same problem on both my laptop and my testbox.  
> It happens everytime and I have yet to compile 2.5.4 
> successfully.  Although, I suspect it's in my config file - 
> I'm just using an old config file I used for my 2.4.17 kernel 
> which works just fine.
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Steve Kieu
> Sent: Tuesday, February 12, 2002 8:49 PM
> To: kernel
> Subject: Re: Unable to compile 2.5.4: "control reaches end of 
> non-void functionm"
> 
> 
> 
> Hi,
> 
> It seems nobody having this problem? No one replies at
> least why, so I just want to add one more case of
> compiling error. Exactly the same message as yours.
> 
> 
> 
> =====
> S.KIEU
> 
http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your Valentines love online.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

