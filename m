Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUBKRW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUBKRW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:22:27 -0500
Received: from emroute1.cind.ornl.gov ([160.91.4.119]:53736 "EHLO
	emroute1.cind.ornl.gov") by vger.kernel.org with ESMTP
	id S266014AbUBKRW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:22:26 -0500
Date: Wed, 11 Feb 2004 12:22:13 -0500
From: Lawrence MacIntyre <lpz@ornl.gov>
Subject: aic7xxx driver, SuperMicro P4DL6, and 2.6.2 kernel
To: linux-kernel@vger.kernel.org
Message-id: <1076520132.17497.41.camel@nautique>
Organization: High Performance Information Infrastructure Group
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I have a dual XEON with a SuperMicro P4DL6 motherboard. It has an
onboard dual AIC7899W controller. I have two disks, one with RH9 and one
with Fedora Core 1. Both work fine. However, I want to upgrade the
Fedora disk to the 2.6.2 kernel. I loaded the latest version of
module-init-tools, procps, and quota, and built the kernel. It won't
boot. It loads scsi_mod.ko and sd_mod.ko, but when it tries to load
aic7xxx.ko, it says:

loading aic7xxx.ko module
insmod: error inserting /lib/aic7xxx.ko: -1 No such device

I downloaded the latest driver from Justin's web site, but it does
exactly the same thing. I added

options aic7xxx aic7xxx=verbose,debug:0xffff

to modprobe.conf, but that didn't help either. 
-- 
    Lawrence MacIntyre     865.574.8696     lpz@ornl.gov
               Oak Ridge National Laboratory
High Performance Information Infrastructure Technology Group

