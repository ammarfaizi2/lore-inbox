Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWGHMbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWGHMbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGHMbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:31:50 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:55377 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964808AbWGHMbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:31:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=XJlC4h0BkDfbg0hLEScP0c1J2hscQiHavjaRFOoA3356+ddCFWvLHV24t4aXeVv+PjKU6ZVoeHoCnx20RR5hsk3Xml/6NFEW18yJhZaxci+iQ+BTejcLVNGFVUSBbIY2TIrPSFR5yfo92BXhZV+TSsK1WiAgCffMiUK6/BKiRmk=
Date: Sat, 8 Jul 2006 21:32:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [ANNOUNCE] libata-tj-stable against v2.6.17.4 available
Message-ID: <20060708123242.GE2592@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

libata-tj-stable patches against v2.6.17.4 are available.

* Hotplug-by-polling added
* Port Multiplier support added back (sil3726 support added)

The patches add the following features to v2.6.17.4.

* New error handling
* IRQ driven PIO (from Albert Lee)
* SATA NCQ support
* Hotplug support
* New PM (Power Management)
* Hotplug-by-poll
* Port Multiplier support

The following drivers support new features.

ahci:		new EH, irq-pio, hotplug, NCQ
ata_piix:	new EH, irq-pio, warmplug (HW restriction), PM
sata_nv:	new EH, irq-pio, hotplug
sata_sil:	new EH, irq-pio, hotplug, PM
sata_sil24:	new EH, irq-pio, hotplug, PM, NCQ, PMP
sata_sis:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL
sata_svw:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL
sata_uli:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL
sata_via:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_vsc:	new EH, irq-pio, hotplug-poll, EXPERIMENTAL

More info can be found at the following URL.

 http://home-tj.org/wiki/index.php/Libata-tj-stable

Patches against v2.6.17.4 are avaialbe at the following URL.

 http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060708.tar.bz2

Please read README carefully before trying the patches.

Thanks.

-- 
tejun
