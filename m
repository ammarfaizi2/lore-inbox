Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281448AbRKFDkq>; Mon, 5 Nov 2001 22:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281449AbRKFDkg>; Mon, 5 Nov 2001 22:40:36 -0500
Received: from cc192618-b.oakrdg1.tn.home.com ([65.8.221.188]:14242 "EHLO
	rdb.linux-help.org") by vger.kernel.org with ESMTP
	id <S281448AbRKFDkd>; Mon, 5 Nov 2001 22:40:33 -0500
Date: Mon, 5 Nov 2001 22:43:26 -0500
From: R Dicaire <rdicaire@ardynet.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 loop.o module problem
Message-Id: <20011105224326.730aa3c7.rdicaire@ardynet.com>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Errors compiling 2.4.14...

While compiling the modules:

loop.c: In function `lo_send':
loop.c:210: warning: implicit declaration of function `deactivate_page'


While installing the modules:

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.14; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.14/kernel/drivers/block/loop.o
depmod:         deactivate_page

gcc 2.95.3

GNU binutils-2.11.90.0.19

Please respond to this email address, I'm not on the list, thanks.
