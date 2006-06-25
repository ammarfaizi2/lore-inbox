Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWFYH3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWFYH3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWFYH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 03:29:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:65253 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750922AbWFYH3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 03:29:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DixrCP9xFHHPa/+wdUQkDrwPVWpx3io/P45mIRohmsrkdy5WRdFbAjxA3GoWhXBU15MYLngb1rZ/vj8OFKN5di5+R6Q9Lvcetgp6KWURqH9asGVXYEmRZIVWft8XSdk9z3FAd0hBbkRARO7bRa4ff9BGOajKYBgryoda/cgLz+M=
Date: Sun, 25 Jun 2006 16:30:03 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management patches against v2.6.17
Message-ID: <20060625073003.GA21435@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.

* New Power Management added
* Port Multiplier support is dropped for the time being

The patches add the following features to v2.6.17.

* New error handling
* IRQ driven PIO (from Albert Lee)
* SATA NCQ support
* Hotplug support
* New PM (Power Management)

The following drivers support new features.

ahci:		new EH, irq-pio, hotplug, NCQ
ata_piix:	new EH, irq-pio, warmplug (HW restriction), PM
sata_nv:	new EH, irq-pio, hotplug
sata_sil:	new EH, irq-pio, hotplug, PM
sata_sil24:	new EH, irq-pio, hotplug, PM, NCQ
sata_sis:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_svw:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_uli:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_via:	new EH, irq-pio, warmplug, EXPERIMENTAL
sata_vsc:	new EH, irq-pio, warmplug, EXPERIMENTAL

More info can be found at the following URL.

 http://home-tj.org/wiki/index.php/Libata-tj-stable

Patches against v2.6.17 are avaialbe at the following URL.

 http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625.tar.bz2

Please read README carefully before trying the patches.

Thanks.

-- 
tejun
