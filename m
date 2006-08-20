Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWHTDZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWHTDZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 23:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWHTDZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 23:25:25 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:60128 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751482AbWHTDZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 23:25:25 -0400
Date: Sat, 19 Aug 2006 20:25:22 -0700
From: Shane <shane@cm.nu>
Subject: IDE issues booting a gigabyte p965-dq6 motherboard
To: linux-kernel@vger.kernel.org
Message-id: <20060820032522.GA3720@cm.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-No-Archive: yes
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

Has anyone had success booting a Gigabyte p965-DQ6
motherboard?  I've tried a GRML CD but the initrd can't
find its CDROM.  Actually it doesn't seem to find any of
the PATA/sata hardware.  My Debian initrd (2.6.18-rc4) sees
the ahci hosts but the system locks during the AHCI driver
loading bit.  Just wondering if there is anything more
fleeding edge out there for ATA drivers without going to
mm?

I believe this is an ich8r controler, ich8 I believe is
supported but couldn't find reference to ich8r.  I do have
the raid disabled and have tried legacy ide mode.

Cheers,
Shane


-- 
http://www.cm.nu/~shane/
