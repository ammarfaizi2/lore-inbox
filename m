Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTETTPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTETTPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:15:44 -0400
Received: from web40612.mail.yahoo.com ([66.218.78.149]:64846 "HELO
	web40612.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263879AbTETTPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:15:44 -0400
Message-ID: <20030520192839.41774.qmail@web40612.mail.yahoo.com>
Date: Tue, 20 May 2003 12:28:39 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.69-bk14 (PPC build) -- sound/ppc/keywest.c:60: structure has no member named `name'
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=sound/ppc
  gcc -Wp,-MD,sound/ppc/.keywest.o.d -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -Iarch/ppc
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -
mstring -fomit-frame-pointer -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=keywest -DKBUILD_MODNAME
=snd_powermac -c -o sound/ppc/keywest.o
sound/ppc/keywest.c
sound/ppc/keywest.c: In function
`keywest_attach_adapter':
sound/ppc/keywest.c:60: structure has no member named
`name'
sound/ppc/keywest.c:68: structure has no member named
`data'
sound/ppc/keywest.c:73: structure has no member named
`name'
make[2]: *** [sound/ppc/keywest.o] Error 1


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
