Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTEINbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbTEINbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:31:32 -0400
Received: from mail.set-software.de ([193.218.212.121]:23713 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP id S263250AbTEINbb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:31:31 -0400
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 09 May 2003 13:42:41 GMT
Message-ID: <20030509.13424122@knigge.local.net>
Subject: 3ware Raid
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is not a "kernel-only" question but maybe someone who knows 3ware 
raid controllers (and the driver) could help me.

Currently my 3ware 6xxx RAID controller tells me that my RAID-Array 
(stripe-set with two maxtor 120 GB disks) is incomplete (even if I 
delete the array and create a new one - after a reboot the array is 
marked "incomplete").

The BIOS of the 3ware controller shows me both disks, but one is 
always makred as "available" and the raid-array is missing one drive.

The strange part: the Linux kernel doesn't care about this and mounts 
my array correctly! And the array works so far - it seems to me, don't 
know if there will be any surprises the next days ;-)


Now... should I care about this? Is my array broken or not? And why 
does the Linux driver think my array is ok and the 3ware BIOS not?

Thanks for any help,
  Michael






