Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUIWRqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUIWRqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIWRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:33:53 -0400
Received: from hadar.amcc.com ([192.195.69.168]:29848 "EHLO hadar.amcc.com")
	by vger.kernel.org with ESMTP id S268107AbUIWRd0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:33:26 -0400
From: "Adam Radford" <aradford@amcc.com>
To: Glenn Johnson <gjohnson@srrc.ars.usda.gov>, linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
Date: Thu, 23 Sep 2004 10:32:27 -0700
Organization: AMCC
X-Sent-Folder-Path: Sent Items
X-Mailer: Oracle Connector for Outlook 9.0.4 51114 (9.0.6627)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <I4I8RQ00.F30@hadar.amcc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn,

The /proc/scsi interface is being deprecated by the SCSI subsystem maintainers.

Support for /proc/scsi/3w-xxxx has been removed from the driver and sysfs support
has been added.  Please download the newer 3dm2 tools from the 3ware software
"In-Engineering Development" website, or, keep your older kernel and tools.

  
If you have any more questions, please contact 3ware/AMCC support.

-Adam

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Glenn Johnson
Sent: Thursday, September 23, 2004 9:09 AM
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi


I have a 3Ware-7500 series card.  I was trying the 2.6.9-rc2-mm2 kernel
and discovered that the 3dmd utility was not working.  A little poking
around revealed that the cause was because the 3Ware directory was not
in /proc/scsi, even though I have CONFIG_SCSI_PROC_FS=y in my config
file.  The 3dmd utility works fine with mainline 2.6.9-rc2 and it worked
with the 2.6.8-mm series of kernels.  Those kernels have a 3w-xxxx
directory in /proc/scsi.

Thanks.

-- 
Glenn Johnson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

