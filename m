Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272065AbTG2UHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272126AbTG2UHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:07:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5000 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272065AbTG2UHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:07:22 -0400
Date: Tue, 29 Jul 2003 17:02:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre9
Message-ID: <Pine.LNX.4.55L.0307291700490.24730@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre9, yet another step in 2.4.22 direction.

It contains a bunch of Netfilter fixes, set of IEEE1394 fixes, couple of
knfsd fixes amongst others.

Expect -pre10 tomorrow.


Summary of changes from v2.4.22-pre8 to v2.4.22-pre9 v2.422-pre9
============================================

<jones:ingate.com>:
  o [IGMP]: linux/igmp.h needs asm/byteorder.h

<martin.bene:icomedias.com>:
  o [NETFILTER]: Add missing include to ip_conntrack_core.h

<pp:netppl.fi>:
  o Avoid annoying "can't emulate rawmode" messages with logitech cordless mice

<vherva:niksula.hut.fi>:
  o NMI watchdog documentation

Adrian Bunk:
  o [NETFILTER]: Add missing Configure.help entry for ipt_recent
  o MTD Configure.help cleanups

Andreas Gruenbacher:
  o Fix warning in fs/binfmt_elf.c

Ben Collins:
  o Include param.h for HZ in ieee1394
  o Interim IEEE-1394 fixes

Harald Welte:
  o [NETFILTER]: Fix a bug in the IRC DCC command parser of ip_conntrack_irc

Maciej Soltysiak:
  o [NETFILTER]: Make REJECT target compliant with RFC 1812

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre9

Neil Brown:
  o knfsd - Convert error code to nfserror code in nfsd_symlink
  o knfsd - BKL is missing in once place in knfsd
  o md -  Resolve problem with refcounting of md arrays

Olof Johansson:
  o [RANDOM]: Fix SMP deadlock in __check_and_rekey()

Patrick McHardy:
  o [NET]: Fix signnedness test in socket filter code
  o [NETFILTER]: Fix problems with iptables MIRROR target
  o [NETFILTER]: Fix issues with iptables REJECT and MIRROR targets wrt. policy routing
  o [NETFILTER]: Fix locking of ipt_helper
  o [NETFILTER]: Drop reference to conntrack after removing confirmed expectation

Tom Rini:
  o PPC32: Allow eth0 and eth1 to work on MPC8xx boards with QS6612 PHYs
  o PPC32: Correctly set intfreq / busfreq on the Motorola 860FADS

