Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbRLHAbd>; Fri, 7 Dec 2001 19:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285708AbRLHAbX>; Fri, 7 Dec 2001 19:31:23 -0500
Received: from 200-171-175-119.dsl.telesp.net.br ([200.171.175.119]:52234 "EHLO
	caern.wolves.com.br") by vger.kernel.org with ESMTP
	id <S285710AbRLHAbK> convert rfc822-to-8bit; Fri, 7 Dec 2001 19:31:10 -0500
Date: Fri, 7 Dec 2001 22:31:05 -0200 (BRST)
From: wolvie_cobain <wolvie@punkass.com>
X-X-Sender: <wolvie@caern.wolves.com.br>
To: <linux-kernel@vger.kernel.org>
Subject: bug??
Message-ID: <Pine.LNX.4.33.0112072224200.8331-100000@caern.wolves.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helo ppl,

I havin trobles compiling the 2.5.1-pre5 and pre6 kernels
more especificaly with the intermezzo filesystem. I dosen't use it for
nothing but i like to test some filesystem in a while and found this error
when compiling the kernel

gcc -D__KERNEL__ -I/thingz/kernelz/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6    -c -o psdev.o psdev.c
psdev.c: In function `presto_psdev_ioctl':
psdev.c:269: `TCGETS' undeclared (first use in this function)
psdev.c:269: (Each undeclared identifier is reported only once
psdev.c:269: for each function it appears in.)
psdev.c:270: warning: unreachable code at beginning of switch statement
make[3]: *** [psdev.o] Error 1
make[3]: Leaving directory `/thingz/kernelz/linux/fs/intermezzo'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/thingz/kernelz/linux/fs/intermezzo'
make[1]: *** [_subdir_intermezzo] Error 2
make[1]: Leaving directory `/thingz/kernelz/linux/fs'
make: *** [_dir_fs] Error 2

i could proceed for this point disablin the intermezzo fylesystem
by the by i just want to tell somebody
if o knew how to fix it i would be happy to help but..
cya
Thomas "Wolvie" Andrade

ps: and sorry bout the english.. it's not my first language, i'm brasilian
=)

"Nós também podemos trazer as coisas de volta.Dizem q somos o sonho de uma
raça
carniceira e talvez seja verdade, mas se nós acreditarmos e sonharmos podemos
mudar o mundo. Nós podemos sonha-lo de novo"
"Sonho de mil gatos"
-------------------------------------------------------------------------------
                /"\
                \ /  CAMPANHA DA FITA ASCII - CONTRA MAIL HTML
                 X   ASCII RIBBON CAMPAIGN - AGAINST HTML MAIL
                / \
-------------------------------------------------------------------------------
				linux user #106516
				ICQ 	   #46105730

