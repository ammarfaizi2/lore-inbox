Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTLQRnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTLQRnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:43:55 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:59606 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264479AbTLQRnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:43:49 -0500
Date: Wed, 17 Dec 2003 18:43:25 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4-bk] build error in page_alloc.c
Message-ID: <20031217174325.GA8593@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just tried to build 2.4 from current bk.
config.gz is attached.

best regards,
axel

gcc -D__KERNEL__ -I/usr/local/src/system/kernel/linus-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=3D2 -march=3Dpentium4   -nostdinc -iwithpr=
efix
include -DKBUILD_BASENAME=3Dpage_alloc  -DEXPORT_SYMTAB -c page_alloc.c
page_alloc.c: In function =1F_alloc_pages':
page_alloc.c:382: error: parse error before '{' token
page_alloc.c:339: warning: unused variable =06reed'
page_alloc.c: At top level:
page_alloc.c:397: error: parse error before "if"
page_alloc.c:405: warning: type defaults to 	nt' in declaration of =1Aone'
page_alloc.c:405: error: =1Aonelist' undeclared here (not in a function)
page_alloc.c:405: warning: data definition has no type or storage class
page_alloc.c:406: error: parse error before "if"
page_alloc.c:258: warning: =02alance_classzone' defined but not used
make[2]: *** [page_alloc.o] Error 1
make[2]: Leaving directory /usr/local/src/system/kernel/linus-2.4/mm'

Linux neon 2.4.24-pre1 #1 Wed Dec 10 14:47:46 CET 2003 i686 unknown unknown
GNU/Linux
 =20
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
quota-tools            3.09.
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         sr_mod nvidia parport_pc parport nfs scanner



____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net=
 |

Eternal nothingness is fine if you happen to be dressed for it.
                -- Woody Allen
____________________________________________________________________________

--k+w/mQv8wyuph6w0
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
E9MbBYSky+gP/eX6eFJjAAA=

--k+w/mQv8wyuph6w0--
