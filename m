Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263109AbSJBPx4>; Wed, 2 Oct 2002 11:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263110AbSJBPx4>; Wed, 2 Oct 2002 11:53:56 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:35704 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S263109AbSJBPxz>; Wed, 2 Oct 2002 11:53:55 -0400
Date: Wed, 02 Oct 2002 08:59:54 -0700
From: Ken Savage <kens1835@shaw.ca>
Subject: 3ware Escalade 7500 init problems on 2.4.19
To: linux-kernel@vger.kernel.org
Message-id: <200210020859.54621.kens1835@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: KMail/1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there..

Just received a 3ware 7500-8 RAID card and am trying to get it installed
on a dual Athlon system with 4GB of RAM, running 2.4.19.

SCSI support and SCSI disk support are enabled.
Low level support for 3w-xxxx is enabled.
The RAID has been flashed to the latest hardware revision.

Kernel loads up fine, and gets to initializing the card, where it waits
for a while as it attempts to init and reinit, etc, the card.  Ultimately,
it simply resets the card and takes the card offline.  'dmesg' reports
the following in the kernel log:

scsi0 : Found a 3ware Storage Controller at 0xc400, IRQ: 11, P-chip: 1.3
scsi0 : 3ware Storage Controller
3w-xxxx: scsi0: Unit #0: Command (0xf4d53800) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (0xf4d53800) timed out, resetting card.
3w-xxxx: scsi0: Reset succeeded.
3w-xxxx: scsi0: Unit #0: Command (0xf4d53800) timed out, resetting card.
scsi: device set offline - not ready or command retry failed after host reset: 
host 0 channel 0 id 0 lun 0


Any ideas what the problem might be?

Ken Savage  kens1835@shaw.ca
AllResearch.com

