Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTGXUcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271725AbTGXUcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:32:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16272 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270436AbTGXUcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:32:06 -0400
Date: Thu, 24 Jul 2003 17:23:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre8
Message-ID: <Pine.LNX.4.55L.0307241721130.7875@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here goes -pre8. It contains network driver updates, IEEE1394 update, a
POSIX compliance fix introduced by the execve() security fixes during
early -pre, amongst others.

Detailed changelog below

Summary of changes from v2.4.22-pre7 to v2.4.22-pre8
============================================

<gorgo:thunderchild.debian.net>:
  o [netdrvr wan] note comx maintainer change, by request

<lethal:unusual.internal.linux-sh.org>:
  o sh64: sh-sci support for SH-5 101/103

<mark.fasheh:oracle.com>:
  o Fix deadlock in journal_create

<taowenhwa:intel.com>:
  o [e100] read skb->len after freeing skb
  o [e100] cu_start: timeout waiting for cu
  o [e100] misc

Andreas Gruenbacher:
  o unshare-files fix breaks file locks

Ben Collins:
  o [SPARC64]: Clear all IRQs at probe time in PCI sabre driver
  o Update IEEE1394 (r1010)

Bhavesh P. Davda:
  o Fix aha152x hangs on pcmcia card eject

Chas Williams:
  o [ATM]: Get config/build dependencies correct

Daniel Ritz:
  o fix ne2k-pci memleak

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre8

Neil Brown:
  o knfsd:   Only set ->reuse for tcp sockets, not udp

Roger Luethi:
  o via-rhine 1.19: One more Rhine-I fix

Scott Feldman:
  o [netdrvr ethtool] add ethtool TSO get/set
  o [e1000] request_irq() failure resulted in freeing twice
  o [e1000] fix VLAN support on PPC64
  o [e1000] missing Tx cleanup opportunities during intr handling
  o [e1000] alloc_etherdev failure didn't cleanup regions
  o [e1000] ethtool diag cleanup
  o [e1000] h/w workaround for mis-fused parts
  o [e1000] s/int/unsigned int/ for descriptor ring indexes
  o [e1000] misc cleanup

