Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUCPSgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUCPSgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:36:46 -0500
Received: from mail.cyclades.com ([64.186.161.6]:53225 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261170AbUCPSgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:36:41 -0500
Date: Tue, 16 Mar 2004 15:14:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-pre4
Message-ID: <Pine.LNX.4.44.0403161458060.1564-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes the fourth -pre of 2.4.26. 

Pretty small (great!), containing a few network updates, SPARC64 fixes,
Bluetooth fixes, IDE update (fixes for AMD chipset driver and inclusion of
Medley software RAID driver by Thomas Horsten), amongst others.


Summary of changes from v2.4.26-pre3 to v2.4.26-pre4
============================================

<colin:gibbsonline.net>:
  o [NET_SCHED]: Use time_after, fixes htb on 64-bit arch

<mlord:pobox.com>:
  o Yet another vmalloc() fixup

<tuncer.ayaz:gmx.de>:
  o [IPVS]: Fix typo in Config.in

Angelo Dell'Aera:
  o [TCP]: Kill westwood bw_sample, set but not used

Bartlomiej Zolnierkiewicz:
  o small cleanup for AMD/nVidia IDE driver
  o IDE AMD/nForce driver update
  o amd74xx.c: fix for !CONFIG_PROCFS
  o fix IDE build for CONFIG_PROC_FS=n
  o new Medley software RAID driver

David S. Miller:
  o [SPARC64]: Handle failed vmalloc_area_pages in module_map correctly
  o [SPARC64]: Update defconfig

Marcel Holtmann:
  o [Bluetooth] Fix race for incoming connections
  o [Bluetooth] Fix error handling for not connected socket
  o [Bluetooth] Fix several copy_to_user() glitches
  o [Bluetooth] Fix non-blocking socket race conditions
  o [Bluetooth] Copy all L2CAP signal frames to the raw sockets
  o [Bluetooth] Send HCI_Reset for some Broadcom dongles

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre4

Theodore Y. T'so:
  o zerout JBD journal descriptor blocks


