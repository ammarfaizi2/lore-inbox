Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbUCTGPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 01:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbUCTGPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 01:15:33 -0500
Received: from mail.cyclades.com ([64.186.161.6]:33930 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263236AbUCTGP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 01:15:28 -0500
Date: Sat, 20 Mar 2004 02:54:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-pre5
Message-ID: <Pine.LNX.4.44.0403200251350.3436-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes the fifth -pre of 2.4.26.

It includes a number of USB bugfixes/updates, SCSI driver/stack fixes from 
Doug Ledford, another ACPI update, amongst others.

This is probably the last -pre of 2.4.26 series.

Detailed changelog follows

Summary of changes from v2.4.26-pre4 to v2.4.26-pre5
============================================

<brill:fs.math.uni-frankfurt.de>:
  o USB Storage: unusual_devs.h entry submission

<dledford:build-base.perf.redhat.com>:
  o scsi_lib.c: Fix sg segment recounting
  o Fix various minor compiler warning issues
  o Fix for Red Hat bug #98264, usb reset locking problem
  o sym53c8xx:  Only do SCSI-3 PPR message based negotiations on SCSI-3 devices or SCSI-2 devices that know to set the DT bit in their INQUIRY return data.
  o scsi_scan.c: Correctness fix for scanning of multi-lun devices
  o scsi_scan.c: Add an option for making linux treat offlined devices as online
  o Update the error handler to use mod_timer
  o Don't leak command structs when no device is found

<jamesl:appliedminds.com>:
  o USB: Fixing HID support for non-explicitly specified usages

<michal_dobrzynski:mac.com>:
  o USB: add IRTrans support to ftdi_sio driver

<mlotek:foobar.pl>:
  o USB: another unusual_devs.h change

<not:just.any.name>:
  o USB: Using physical extents instead of logical ones for NEC USB HID gamepads

<pg:futureware.at>:
  o USB: more FTDI-SIO devices

<rene.herman:keyaccess.nl>:
  o 8139too assertions

<ricklind:us.ibm.com>:
  o block layer accounting fix

Alan Stern:
  o USB: fix unneeded SubClass entry in unusual_devs.h

Dave Kleikamp:
  o JFS: zero new log pages, etc

David Brownell:
  o USB Gadget: ethernet gadget locking tweaks
  o USB: EHCI updates (mostly periodic schedule scanning)
  o USB Gadget: make usb gadget strings talk utf-8
  o USB: add "gadget_chips.h"
  o USB: gadget config buffer utilities
  o USB: usb gadget, dualspeed {run,compile}-time flags
  o USB: gadget zero, simplified controller-specific configuration

Don Fry:
  o pcnet32 correct names for changes
  o pcnet32.c oops

Greg Kroah-Hartman:
  o USB: add support for the Aceeca Meazura device to the visor driver

Ian Abbott:
  o USB: ftdi_sio new PIDs and name fix for sysfs

Jeff Garzik:
  o Update pci_ids.h with new Intel PCI ids
  o Add Intel ICH6 irq router
  o Add Intel PCI ids to i810_audio
  o Add Intel PCI ids to IDE (PATA) driver
  o [netdrvr natsemi] Fix RX DMA mapping

Kumar Gala:
  o [PPC32] Modified OCP support so its not IBM specific and added new APIs to allow modification of the device tree before drivers are bound

Len Brown:
  o [ACPI] acpi_wakeup_address - print only when broken
  o [ACPI] global lock macro fixes (Paul Menage, Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=1669
  o [ACPI] SMP poweroff (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1141
  o [ACPI] ACPICA 20040311 from Bob Moore
  o [ACPI] add boot parameters "acpi_osi=" and "acpi_serialize" acpi_osi= will disable the _OSI method -- which by default tells the BIOS to behave as if Windows is the OS.

Luca Tettamanti:
  o USB: fix hid-core compile warning

Manfred Spraul:
  o forcedeth update

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre5

Martin Diehl:
  o USB: fix stack usage in pl2303 driver

Paul Mackerras:
  o [PPC32] Add support for the EP405/EP405PC embedded platforms
  o [PPC32] Avoid prefetching past the end of the source in copy routines
  o [PPC32] Add stabs debug entries to some assembler files
  o [PPC32] Add support for the Redwood 5 and 6 embedded boards

Paulo Marques:
  o USB: usblp.c (Was: usblp_write spins forever after an error)

Per Winkvist:
  o USB Storage: unusual devs fix for Pentax cameras

Pete Zaitcev:
  o USB: Change the USB Maintainer entry
  o USB: fix hid-input problem with BTC keyboards
  o Trivial input.c change: Add missing new line on error case printk()

Petko Manolov:
  o USB: patch for pegasus.h
  o USB: another patch to pegasus.h

Richard Curnow:
  o USB: Fix handling of bounce buffers by rh_call_control

Stelian Pop:
  o sonypi driver update
  o meye driver update

Thomas Chen:
  o USB: fix little bug in io_edgeport.c

Thomas Sailer:
  o USB: OSS audio driver workaround for buggy descriptors


