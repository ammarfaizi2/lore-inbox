Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312479AbSC3NS0>; Sat, 30 Mar 2002 08:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312484AbSC3NSR>; Sat, 30 Mar 2002 08:18:17 -0500
Received: from web11208.mail.yahoo.com ([216.136.131.190]:23826 "HELO
	web11208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312479AbSC3NSG>; Sat, 30 Mar 2002 08:18:06 -0500
Message-ID: <20020330131805.27670.qmail@web11208.mail.yahoo.com>
Date: Sat, 30 Mar 2002 05:18:05 -0800 (PST)
From: Matti Langvall <langvall_2000@yahoo.com>
Subject: 2.4.9-pre5 pcilynx undeclared variables
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

got this error trying to compile 2.4.19-pre5

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundar 
y=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h 
-DKBUILD_BASENAME=pcilynx  -c -o pcilynx.o pcilynx.c
pcilynx.c: In function `mem_open':
pcilynx.c:647: `num_of_cards' undeclared (first use in
this function)
pcilynx.c:647: (Each undeclared identifier is reported
only once
pcilynx.c:647: for each function it appears in.)
pcilynx.c:647: `cards' undeclared (first use in this
function)
pcilynx.c: In function `aux_poll':
pcilynx.c:706: `cards' undeclared (first use in this
function)
make[2]: *** [pcilynx.o] Error 1
make[2]: Leaving directory
`/usr/src/linux/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Please reply to this adress as i'm not subscribing to
lkml.

Best regards
Matti L

__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - send holiday greetings for Easter, Passover
http://greetings.yahoo.com/
