Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUIWQMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUIWQMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUIWQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:12:18 -0400
Received: from symbion.srrc.usda.gov ([199.133.86.40]:22152 "EHLO
	node1.cluster.srrc.usda.gov") by vger.kernel.org with ESMTP
	id S266517AbUIWQJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:09:07 -0400
Subject: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
From: Glenn Johnson <gjohnson@srrc.ars.usda.gov>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: USDA, ARS, SRRC
Message-Id: <1095955746.11943.7.camel@node1.cluster.srrc.usda.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 11:09:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

