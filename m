Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUFOWGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUFOWGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUFOWGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:06:14 -0400
Received: from hadar.amcc.com ([192.195.69.168]:47750 "EHLO hadar.amcc.com")
	by vger.kernel.org with ESMTP id S265986AbUFOWGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:06:13 -0400
From: "Adam Radford" <aradford@amcc.com>
To: Peter Maas <fedora@rooker.dyndns.org>, linux-kernel@vger.kernel.org
Subject: RE: 3ware 9500S Drivers (mm kernel)
Date: Tue, 15 Jun 2004 15:05:22 -0700
Organization: AMCC
X-Sent-Folder-Path: Sent Items
X-Mailer: Oracle Connector for Outlook 9.0.4 51114 (9.0.6627)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <HZDEQB01.6HW@hadar.amcc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

The 3ware management tools quit working when we removed the proc_name interface 
during the re-write and created sysfs attributes.  We are modifying the 3ware
management tools to use the sysfs interface for rescan's, etc.

I am also working with Bruce Allen (smartmontools developer) to make the
3w-9xxx driver work with smartmontools.  This shouldn't require any driver changes.

-Adam

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Peter Maas
Sent: Tuesday, June 15, 2004 2:05 PM
To: linux-kernel@vger.kernel.org
Subject: 3ware 9500S Drivers (mm kernel)


I've been using the 3ware 9500 drivers in the mm kernel for a while now
without any problems, this is on a dual opteron with a 9500S-12 controller
with 6 disk formatted as a raid-5. Are these going to be included in the
vanilla kernel soon?

My only complaints with the drivers are that smartctl doesnt work with them
(fedora core 2), and the 3ware management tools from the 3ware cd wont work
with the mm drivers (wont detect controller).

Thanks

Peter Maas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

