Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUJVVaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUJVVaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUJVV1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:27:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267921AbUJVVXu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:23:50 -0400
Date: Fri, 22 Oct 2004 16:59:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-rc1
Message-ID: <20041022185953.GA4886@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the first release candidate of v2.4.28.

It contains a small number of changes from -pre4, a couple of libata bugfixes,
a PIIX IDE driver DMA bugfix, USB fixes, and some tmpfs corrections.

Detailed changelog follows.

Summary of changes from v2.4.28-pre4 to v2.4.28-rc1
============================================

<chaus:rz.uni-potsdam.de>:
  o Fix bug in PIIX code where DMA could be turned on without proper hw configuration (bugzilla bug #3473)

Bartlomiej Zolnierkiewicz:
  o libata: PCI IDE legacy mode fix
  o [libata] do not memset() SCSI request buf in a get-reference style function
  o [libata piix] Fix PATA UDMA masks

Benjamin Herrenschmidt:
  o Mikael Pettersson: PowerPC 745x coherency fix

Dave Jones:
  o davej CREDITS update

François Romieu:
  o sata_nv: enable hotplug event on successfull init only
  o sata_nv: wrong failure path and leak
  o sata_nv: housekeeping for goto labels

Herbert Xu:
  o Fix hiddev devfs oops

Hugh Dickins:
  o tmpfs: stop negative dentries
  o tmpfs: fix shmem_file_write return value

Jake Moilanen:
  o PPC64 build break

Jeff Garzik:
  o [libata] add hook, and export functions needed for sata2 drivers
  o [libata] add sata_uli driver for ULi (formerly ALi) SATA

Jens Axboe:
  o scsi io completion bug

Maciej W. Rozycki:
  o "console=" parameter ignored

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc1

Margit Schubert-While:
  o Add prism54 to MAINTAINERS

Paul Fulghum:
  o serial send_break duration fix

Pete Zaitcev:
  o Crash with cat /proc/bus/usb/devices and disconnect

Özkan Sezer:
  o e1000 driver, gcc-3.4 inlining fix

