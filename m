Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135879AbRDYPNI>; Wed, 25 Apr 2001 11:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRDYPMt>; Wed, 25 Apr 2001 11:12:49 -0400
Received: from bbm.ca ([206.116.211.2]:59803 "HELO bbmfw.bbm.ca")
	by vger.kernel.org with SMTP id <S135879AbRDYPMk>;
	Wed, 25 Apr 2001 11:12:40 -0400
Message-ID: <8366512BA71AD2119FAE00A0C9D634FAFE3739@torex1.tor.bbm.ca>
From: Ahmed Warsame <awarsame@bbm.ca>
To: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org, ak@suse.de,
        axboe@suse.de, astor@fast.no
Subject: NTOP for Redhat
Date: Wed, 25 Apr 2001 10:55:44 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to install my Linux Redhat the Network Monitoring system call Ntop
and the following messages is what I am getting each time I execute make.

I thought Libpcap is what is needed and I installed but it did not help.

Can any body out there help me whit this.

The following is the message that I am receiving form the system
installations

Thanks

creating config.h
config.h is unchanged
make  all-recursive
make[1]: Entering directory `/etc/ntop/ntop-1.3.1'
Making all in gdchart0.94b
make[2]: Entering directory `/etc/ntop/ntop-1.3.1/gdchart0.94b'
cc -Igd1.3 -I. -g -c gdc.c
cc -Igd1.3 -I. -g -c gdchart.c
cc -g -c price_conv.c
cc -Igd1.3 -I. -g -c gdc_pie.c
cd gd1.3 ; make -f Makefile libgd.a
make[3]: Entering directory `/etc/ntop/ntop-1.3.1/gdchart0.94b/gd1.3'
cc -O   -c -o gd.o gd.c
cc -O   -c -o gdfontt.o gdfontt.c
cc -O   -c -o gdfonts.o gdfonts.c
cc -O   -c -o gdfontmb.o gdfontmb.c
cc -O   -c -o gdfontl.o gdfontl.c
cc -O   -c -o gdfontg.o gdfontg.c
rm -f libgd.a
ar rc libgd.a gd.o gdfontt.o gdfonts.o gdfontmb.o \
        gdfontl.o gdfontg.o
make[3]: Leaving directory `/etc/ntop/ntop-1.3.1/gdchart0.94b/gd1.3'
make[2]: Leaving directory `/etc/ntop/ntop-1.3.1/gdchart0.94b'
Making all in .
make[2]: Entering directory `/etc/ntop/ntop-1.3.1'
/bin/sh ./libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I./gdchart0.94b
-I/usr/include/pcap    -g -O2 -pipe -c admin.c
mkdir .libs
gcc -DHAVE_CONFIG_H -I. -I./gdchart0.94b -I/usr/include/pcap -g -O2 -pipe -c
admin.c  -fPIC -DPIC -o .libs/admin.lo
In file included from admin.c:23:
ntop.h:380: pcap.h: No such file or directory
In file included from admin.c:23:
ntop.h:465: field `h' has incomplete type
ntop.h:567: parse error before `pcap_t'
ntop.h:567: warning: no semicolon at end of struct or union
ntop.h:572: `filter' redeclared as different kind of symbol
/usr/include/ncurses.h:447: previous declaration of `filter'
ntop.h:655: parse error before `}'
ntop.h:655: warning: data definition has no type or storage class
ntop.h:1083: field `fcode' has incomplete type
ntop.h:1277: field `h' has incomplete type
In file included from ntop.h:1534,
                 from admin.c:23:
globals-core.h:38: parse error before `device'
globals-core.h:38: warning: data definition has no type or storage class
make[2]: *** [admin.lo] Error 1
make[2]: Leaving directory `/etc/ntop/ntop-1.3.1'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/etc/ntop/ntop-1.3.1'
make: *** [all-recursive-am] Error 2
