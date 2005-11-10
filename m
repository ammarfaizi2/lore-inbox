Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVKJUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVKJUkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKJUkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:40:45 -0500
Received: from web30605.mail.mud.yahoo.com ([68.142.200.128]:52647 "HELO
	web30605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932085AbVKJUko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:40:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CHIRrfLfssKbzFZON2CK48p+4HUj34jYOTbgb+ZMDsIfvuBUCqfDdGNSuAfxjQWh0Gj4Oi0yqYNQh+DgEeWS0zESq1Tx1ZI9lPd4cIXnFnYOiIvEm4Leqw/UExgACrG358CGDE2AA6/5kGyTfSaPdeJgyn5jpI6J5fxhtBvmmuE=  ;
Message-ID: <20051110204041.41115.qmail@web30605.mail.mud.yahoo.com>
Date: Thu, 10 Nov 2005 12:40:41 -0800 (PST)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: 3Ware and 2.6.14, problem resurrected
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem introduced in 2.6.12-mm2 as described
below appears to have resurfaced in the latest kernel,
2.6.14.

3ware 9000 Storage Controller device driver for Linux
v2.26.03.019fw.
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level,
low) -> IRQ 18
scsi3 : 3ware 9000 Storage Controller
3w-9xxx: scsi3: Found a 3ware 9000 Storage Controller
at 0xfceffc00, IRQ: 18.
3w-9xxx: scsi3: Firmware FE9X 2.08.00.003, BIOS BE9X
2.03.01.052, Ports: 12.
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI
revision: 00
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi3, channel 0, id 0, lun
0
Attached scsi generic sg1 at scsi3, channel 0, id 0,
lun 0,  type 0

For a full description, view below

http://lkml.org/lkml/2005/6/26/83

Thanks


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
