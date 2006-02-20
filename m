Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWBTSCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBTSCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWBTSCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:02:14 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:38817 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S932241AbWBTSCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:02:11 -0500
Subject: Areca RAID driver remaining items?
From: Dax Kelson <dax@gurulabs.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: billion.wu@areca.com.tw, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       erich@areca.com.tw, arjan@infradead.org, oliver@neukum.org
Content-Type: text/plain
Date: Mon, 20 Feb 2006 11:02:32 -0700
Message-Id: <1140458552.3495.26.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be the most current version of the driver:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/broken-out/areca-raid-linux-scsi-driver.patch

Is this the current TODO list?

=================
Issues not yet patched:

13. uintNN_t int types:  use kernel types except for userspace
interfaces
14. use kernel-doc
18. Put arcmsr.txt in Documentation/scsi/, not in scsi/arcmsr/.
19. Maybe use sysfs (/sys) instead of /proc.
20. check stack usage, init/exit sections;
=================
   
At one point this comment was made:

"There's lots of architectural problems.  It's doing it's own queueing,
it's stuffing kernel structures into memory on the hardware and so on.
Basically someone knowledgeable about the hardware needs to start from
scratch on it."

What are the show stoppers that prevents a merge into the Linus tree?

Dax Kelson

