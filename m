Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281105AbRKKWD0>; Sun, 11 Nov 2001 17:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281108AbRKKWDH>; Sun, 11 Nov 2001 17:03:07 -0500
Received: from CPE-61-9-148-175.vic.bigpond.net.au ([61.9.148.175]:30960 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S281105AbRKKWDF>; Sun, 11 Nov 2001 17:03:05 -0500
Message-ID: <3BEEF1CA.51423E2@eyal.emu.id.au>
Date: Mon, 12 Nov 2001 08:46:50 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.15-pre3: missing functions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.15-pre3/kernel/drivers/md/lvm-mod.o
depmod:         free_kiovec_sz
depmod:         alloc_kiovec_sz

These are in a newer (in 2.4.13-ac8) fs/iobuf.c which has many changes
relative to this (pre3) so a simple copy accross may be too drastic.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
