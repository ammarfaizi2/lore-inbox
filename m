Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSF2UWh>; Sat, 29 Jun 2002 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSF2UWg>; Sat, 29 Jun 2002 16:22:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:57075 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314277AbSF2UWf>; Sat, 29 Jun 2002 16:22:35 -0400
Date: Sat, 29 Jun 2002 22:24:52 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: DocBook-problem with kernel-api in 2.4.19-rc1
Message-ID: <Pine.NEB.4.44.0206292219310.18640-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's the following error when I try a "make psdocs" in 2.4.19-rc1:

<--  snip  -->

$ make psdocs
chmod 755 /home/bunk/linux/linux/scripts/docgen
chmod 755 /home/bunk/linux/linux/scripts/gen-all-syms
chmod 755 /home/bunk/linux/linux/scripts/kernel-doc
make -C /home/bunk/linux/linux/Documentation/DocBook books
make[1]: Entering directory `/home/bunk/linux/linux/Documentation/DocBook'
/home/bunk/linux/linux/scripts/docgen
...
/home/bunk/linux/linux/kernel/sysctl.c /home/bunk/linux/linux/lib/string.c
/home/bunk/linux/linux/lib/vsprintf.c /home/bunk/linux/linux/net/netsyms.c
<kernel-api.tmpl >kernel-api.sgml
Error(2021): cannot understand prototype: 'struct seq_operations slabinfo_op = '
make[1]: Leaving directory `/home/bunk/linux/linux/Documentation/DocBook'
make -C Documentation/DocBook ps
make[1]: Entering directory `/home/bunk/linux/linux/Documentation/DocBook'
db2ps kernel-api.sgml
Using catalogs: /etc/sgml/catalog
Using stylesheet: /usr/share/sgml/docbook/utils-0.6.10/docbook-utils.dsl#print
Working on: /home/bunk/linux/linux/Documentation/DocBook/kernel-api.sgml
jade:/home/bunk/linux/linux/Documentation/DocBook/kernel-api.sgml:668:12:E:
end tag for "SECT1" which is not finished
make[1]: *** [kernel-api.ps] Error 8
make[1]: Leaving directory `/home/bunk/linux/linux/Documentation/DocBook'
make: *** [psdocs] Error 2
$

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

