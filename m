Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312323AbSC3AYD>; Fri, 29 Mar 2002 19:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312325AbSC3AXy>; Fri, 29 Mar 2002 19:23:54 -0500
Received: from CPE-203-51-25-11.nsw.bigpond.net.au ([203.51.25.11]:26353 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312323AbSC3AXh>; Fri, 29 Mar 2002 19:23:37 -0500
Message-ID: <3CA50587.84166129@eyal.emu.id.au>
Date: Sat, 30 Mar 2002 11:23:35 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: neofb.c compile failure
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes pre5.

Everything offered is selected as a module.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=neofb  -c -o neofb.o neofb.c
neofb.c: In function `neofb_set_par':
neofb.c:644: `FB_ACCEL_NEOMAGIC_NM2070' undeclared (first use in this
function)
neofb.c:644: (Each undeclared identifier is reported only once
neofb.c:644: for each function it appears in.)
neofb.c:648: `FB_ACCEL_NEOMAGIC_NM2090' undeclared (first use in this
function)
neofb.c:649: `FB_ACCEL_NEOMAGIC_NM2093' undeclared (first use in this
function)
neofb.c:650: `FB_ACCEL_NEOMAGIC_NM2097' undeclared (first use in this
function)
neofb.c:651: `FB_ACCEL_NEOMAGIC_NM2160' undeclared (first use in this
function)
neofb.c:652: `FB_ACCEL_NEOMAGIC_NM2200' undeclared (first use in this
function)
neofb.c:653: `FB_ACCEL_NEOMAGIC_NM2230' undeclared (first use in this
function)
neofb.c:654: `FB_ACCEL_NEOMAGIC_NM2360' undeclared (first use in this
function)
neofb.c:655: `FB_ACCEL_NEOMAGIC_NM2380' undeclared (first use in this
function)
neofb.c:645: warning: unreachable code at beginning of switch statement
neofb.c:703: warning: unreachable code at beginning of switch statement
neofb.c: In function `neoCalcVCLK':
neofb.c:906: `FB_ACCEL_NEOMAGIC_NM2200' undeclared (first use in this
function)
neofb.c:907: `FB_ACCEL_NEOMAGIC_NM2230' undeclared (first use in this
function)
neofb.c:908: `FB_ACCEL_NEOMAGIC_NM2360' undeclared (first use in this
function)
neofb.c:909: `FB_ACCEL_NEOMAGIC_NM2380' undeclared (first use in this
function)
neofb.c: In function `neo_init_hw':
neofb.c:1998: `FB_ACCEL_NEOMAGIC_NM2070' undeclared (first use in this
function)
neofb.c:2007: `FB_ACCEL_NEOMAGIC_NM2090' undeclared (first use in this
function)
neofb.c:2008: `FB_ACCEL_NEOMAGIC_NM2093' undeclared (first use in this
function)
neofb.c:2017: `FB_ACCEL_NEOMAGIC_NM2097' undeclared (first use in this
function)
neofb.c:2026: `FB_ACCEL_NEOMAGIC_NM2160' undeclared (first use in this
function)
neofb.c:2035: `FB_ACCEL_NEOMAGIC_NM2200' undeclared (first use in this
function)
neofb.c:2046: `FB_ACCEL_NEOMAGIC_NM2230' undeclared (first use in this
function)
neofb.c:2057: `FB_ACCEL_NEOMAGIC_NM2360' undeclared (first use in this
function)
neofb.c:2068: `FB_ACCEL_NEOMAGIC_NM2380' undeclared (first use in this
function)
neofb.c:1999: warning: unreachable code at beginning of switch statement
neofb.c: In function `neo_alloc_fb_info':
neofb.c:2120: `FB_ACCEL_NEOMAGIC_NM2070' undeclared (first use in this
function)
neofb.c:2123: `FB_ACCEL_NEOMAGIC_NM2090' undeclared (first use in this
function)
neofb.c:2126: `FB_ACCEL_NEOMAGIC_NM2093' undeclared (first use in this
function)
neofb.c:2129: `FB_ACCEL_NEOMAGIC_NM2097' undeclared (first use in this
function)
neofb.c:2132: `FB_ACCEL_NEOMAGIC_NM2160' undeclared (first use in this
function)
neofb.c:2135: `FB_ACCEL_NEOMAGIC_NM2200' undeclared (first use in this
function)
neofb.c:2138: `FB_ACCEL_NEOMAGIC_NM2230' undeclared (first use in this
function)
neofb.c:2141: `FB_ACCEL_NEOMAGIC_NM2360' undeclared (first use in this
function)
neofb.c:2144: `FB_ACCEL_NEOMAGIC_NM2380' undeclared (first use in this
function)
neofb.c:2121: warning: unreachable code at beginning of switch statement
neofb.c: At top level:
neofb.c:2298: `FB_ACCEL_NEOMAGIC_NM2070' undeclared here (not in a
function)
neofb.c:2298: initializer element is not constant
neofb.c:2298: (near initialization for `neofb_devices[0].driver_data')
neofb.c:2301: `FB_ACCEL_NEOMAGIC_NM2090' undeclared here (not in a
function)
neofb.c:2301: initializer element is not constant
neofb.c:2301: (near initialization for `neofb_devices[1].driver_data')
neofb.c:2304: `FB_ACCEL_NEOMAGIC_NM2093' undeclared here (not in a
function)
neofb.c:2304: initializer element is not constant
neofb.c:2304: (near initialization for `neofb_devices[2].driver_data')
neofb.c:2307: `FB_ACCEL_NEOMAGIC_NM2097' undeclared here (not in a
function)
neofb.c:2307: initializer element is not constant
neofb.c:2307: (near initialization for `neofb_devices[3].driver_data')
neofb.c:2310: `FB_ACCEL_NEOMAGIC_NM2160' undeclared here (not in a
function)
neofb.c:2310: initializer element is not constant
neofb.c:2310: (near initialization for `neofb_devices[4].driver_data')
neofb.c:2313: `FB_ACCEL_NEOMAGIC_NM2200' undeclared here (not in a
function)
neofb.c:2313: initializer element is not constant
neofb.c:2313: (near initialization for `neofb_devices[5].driver_data')
neofb.c:2316: `FB_ACCEL_NEOMAGIC_NM2230' undeclared here (not in a
function)
neofb.c:2316: initializer element is not constant
neofb.c:2316: (near initialization for `neofb_devices[6].driver_data')
neofb.c:2319: `FB_ACCEL_NEOMAGIC_NM2360' undeclared here (not in a
function)
neofb.c:2319: initializer element is not constant
neofb.c:2319: (near initialization for `neofb_devices[7].driver_data')
neofb.c:2322: `FB_ACCEL_NEOMAGIC_NM2380' undeclared here (not in a
function)
neofb.c:2322: initializer element is not constant
neofb.c:2322: (near initialization for `neofb_devices[8].driver_data')
make[2]: *** [neofb.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/video'


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
