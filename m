Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTKUTG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTKUTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:06:57 -0500
Received: from intra.cyclades.com ([64.186.161.6]:20931 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264416AbTKUTGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:06:55 -0500
Date: Fri, 21 Nov 2003 16:40:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-rc3
Message-ID: <Pine.LNX.4.44.0311211638320.24113-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

A few critical problems showed up, so here is -rc3.


Summary of changes from v2.4.23-rc2 to v2.4.23-rc3
============================================

<amir.noam:intel.com>:
  o [bonding] fix creation of /proc/net/bonding dir

<debian:abeckmann.de>:
  o [SPARC]: Make check_asm.sh not get confused by .section .note.GNU-stack output by newer gcc

<len.brown:intel.com>:
  o [ACPI] "pci=noacpi" -- replace two sets of flags with one: acpi_noirq
  o [ACPI] "pci=noacpi" -- 2.4.23 specific part of previous 2.4.22 fix

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc3

David Engebretsen:
  o Put autoconsole option at the front of the cmd line
  o Fix comment to reflect correct file name
  o fix byte order in comparison

Ed Vance:
  o Fix ST16C654 UART support broke by ELAN patches

Herbert Xu:
  o [netdrvr tg3] fix BCM5705 pending-RX count (was 64, now 63)

Matthew Wilcox:
  o Fix panic-at-boot

Paul Mackerras:
  o PPC64: Update the _syscallN macros to indicate the correct clobbers
  o PPC64: Ensure we get the correct error_code passed to do_page_fault
  o PPC64: Fix alignment in vmlinux.lds
  o PPC64: Make kernel RAM user-inaccessible on iSeries
  o PPC64: Fix compilation of sys_ppc32.c



