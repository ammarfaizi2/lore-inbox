Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289321AbSAIKCW>; Wed, 9 Jan 2002 05:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289320AbSAIKCM>; Wed, 9 Jan 2002 05:02:12 -0500
Received: from web13103.mail.yahoo.com ([216.136.174.148]:48951 "HELO
	web13103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289318AbSAIKCD>; Wed, 9 Jan 2002 05:02:03 -0500
Message-ID: <20020109100202.22285.qmail@web13103.mail.yahoo.com>
Date: Wed, 9 Jan 2002 11:02:02 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: undefined reference to `local symbols in discarded section .text.exit
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020109010122.GC822@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- CaT <cat@zip.com.au> a écrit : > I have modules
and hotplug turned on (but nothing
> turned on in the
> hotplug suboptions) but I get this error anyway:
> 
>         /usr/src/linux/arch/i386/lib/lib.a
> /usr/src/linux/lib/lib.a
> /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> net/network.o(.text.lock+0x1730): undefined
> reference to `local symbols
> in discarded section .text.exit'
> make: *** [vmlinux] Error 1

your binutils needs an upgrade
had the same problem and now i'm using binutils 2.11.2
without problems

hope it helps


=====
--------------------------------------------
                         ,-----.
                       ," ^   ^ ",
                       |  @   @  |
             ----OOOO---------------OOOO----

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
