Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267062AbSK2OYO>; Fri, 29 Nov 2002 09:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbSK2OYO>; Fri, 29 Nov 2002 09:24:14 -0500
Received: from cantor.espacecourbe.com ([205.205.35.2]:32764 "EHLO
	cantor.espacecourbe.com") by vger.kernel.org with ESMTP
	id <S267062AbSK2OYN>; Fri, 29 Nov 2002 09:24:13 -0500
Message-ID: <34053.192.168.1.21.1038580281.squirrel@courriel.espacecourbe.com>
Date: Fri, 29 Nov 2002 09:31:21 -0500 (EST)
Subject: tridentfb.c error kernel 2.5.50
From: "Dominique Arpin" <dominique@espacecourbe.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

           i have some problem to compile the tridentfd driver on the
           Kernel 2.5.50.I'm not sure this is the right mailinglist to submit my problem, but if u
can help me.This problem doesnt appear on the 2.4.19 kernel. Did I miss something?

gcc -Wp,-MD,drivers/video/.tridentfb.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE  
 -DKBUILD_BASENAME=tridentfb -DKBUILD_MODNAME=tridentfb   -c -o
drivers/video/tridentfb.o drivers/video/tridentfb.cdrivers/video/tridentfb.c:64: field `gen' has incomplete type
drivers/video/tridentfb.c: In function `trident_set_disp':
drivers/video/tridentfb.c:1054: dereferencing pointer to incomplete type
drivers/video/tridentfb.c: At top level:
drivers/video/tridentfb.c:1086: variable `trident_hwswitch' has
initializer but incomplete typedrivers/video/tridentfb.c:1087: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1087: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1088: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1088: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1089: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1089: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1090: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1090: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1091: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1091: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1092: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1092: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1093: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1093: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1094: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1094: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1095: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1095: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c:1097: warning: excess elements in struct
initializerdrivers/video/tridentfb.c:1097: warning: (near initialization for
`trident_hwswitch')drivers/video/tridentfb.c: In function `tridentfb_init':
drivers/video/tridentfb.c:1204: `fbgen_switch' undeclared (first use in
this function)drivers/video/tridentfb.c:1204: (Each undeclared identifier is reported
only oncedrivers/video/tridentfb.c:1204: for each function it appears in.)
drivers/video/tridentfb.c:1205: `fbgen_update_var' undeclared (first use
in this function)drivers/video/tridentfb.c:1228: warning: implicit declaration of function
`fbgen_get_var'drivers/video/tridentfb.c:1230: warning: implicit declaration of function
`fbgen_set_disp'drivers/video/tridentfb.c: At top level:
drivers/video/tridentfb.c:1289: unknown field `fb_get_fix' specified in
initializerdrivers/video/tridentfb.c:1289: `fbgen_get_fix' undeclared here (not in a
function)drivers/video/tridentfb.c:1289: initializer element is not constant
drivers/video/tridentfb.c:1289: (near initialization for
`tridentfb_ops.owner')drivers/video/tridentfb.c:1290: unknown field `fb_get_var' specified in
initializerdrivers/video/tridentfb.c:1290: `fbgen_get_var' undeclared here (not in a
function)drivers/video/tridentfb.c:1290: initializer element is not constant
drivers/video/tridentfb.c:1290: (near initialization for
`tridentfb_ops.fb_open')drivers/video/tridentfb.c:1291: `fbgen_set_var' undeclared here (not in a
function)[....]
drivers/video/tridentfb.c:1296: initializer element is not constant
drivers/video/tridentfb.c:1296: (near initialization for `tridentfb_ops')
make[2]: *** [drivers/video/tridentfb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

My hardware:
laptop presario 1200
TridentCyberblade 8 mb

and sorry for my english :)

-- 
Dominique Arpin_______________________[   espace
gestionnaire réseau                     courbe    ]

                                          http://www.espacecourbe.com/
                                          téléphone    514.933.9861
                                          télécopieur  514.933.9546


