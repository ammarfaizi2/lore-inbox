Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSKOSB6>; Fri, 15 Nov 2002 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSKOSB6>; Fri, 15 Nov 2002 13:01:58 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38568 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S266841AbSKOSB4>; Fri, 15 Nov 2002 13:01:56 -0500
Date: Fri, 15 Nov 2002 13:10:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-rc2
Message-ID: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -rc2, fixing the lcall DoS.



Summary of changes from v2.4.20-rc1 to v2.4.20-rc2
============================================

<cel@citi.umich.edu>:
  o sock_writable not appropriate for TCP sockets

<hch@sgi.com>:
  o fix file system corruption under load

<jgarzik@redhat.com>:
  o Use dev_kfree_skb_any not dev_kfree_skb in tg3 net driver function tg3_free_rings.

<marcelo@freak.distro.conectiva>:
  o Undo latest hid-input fixes: they are broken
  o Reverse order of BK config checkout entries
  o Changed EXTRAVERSION to -rc2

<mkp@mkp.net>:
  o Update credits

<rth@are.twiddle.net>:
  o Fix carry ripple in 3 and 4 word addition and subtraction macros

<tytso@think.thunk.org>:
  o HTREE backwards compatibility patch

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Enable the merged AMD pm driver

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o [TCP] Do not update rcv_nxt until ts_recent is updated

Ben Collins <bcollins@debian.org>:
  o [TG3]: TG3_HW_STATUS_SIZE should be 0x50 not 0x80

c-d.hailfinger.kernel.2002-q4@gmx.net <c-d.hailfinger.kernel.2002-Q4@gmx.net>:
  o restore framebuffer console after suspend

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Translate SO_{SND,RCV}TIMEO socket options
  o [SPARC64]: Handle kernel integer divide by zero properly
  o [SPARC64]: Check DRM_NEW not DRM in ioctl32.c
  o [SPARC64]: Fix accidental clobbering of register on cheetahplus

David S. Miller <davem@redhat.com>:
  o Fix tg3 net driver to properly disable interrupts during some TX operations

Edward Peng <edward_peng@dlink.com.tw>:
  o sundance net driver updates

Joshua Uziel <uzi@uzix.org>:
  o [SPARC64]: 0x22/0x10 is Ultra-I/spitfire

Pete Zaitcev <zaitcev@redhat.com>:
  o [sparc] Fix off-by-one in s/g handling

Petr Vandrovec <VANDROVE@vc.cvut.cz>:
  o Fix ncpfs file creation issue

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix lcall DoS

r.e.wolff@bitwizard.nl <R.E.Wolff@BitWizard.nl>:
  o Fix SX driver detection

Tom Rini <trini@kernel.crashing.org>:
  o Fix a thinko in arch/ppc/kernel/ppc_ksyms.c

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o another kmap imbalance in 2.4.x/2.5.x RPC

Vojtech Pavlik <vojtech@suse.cz>:
  o Add vt8235 support


