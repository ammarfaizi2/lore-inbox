Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWICA7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWICA7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 20:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWICA7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 20:59:37 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:22663 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751814AbWICA7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 20:59:37 -0400
Message-ID: <44FA28F7.8010001@bellsouth.net>
Date: Sat, 02 Sep 2006 19:59:35 -0500
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No RAID/LVM config in 2.6.18-rc5-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to build 2.6.18-rc5-mm1 from scratch, but I can't find the 
config options for multi-device (RAID and LVM).  If I go ahead and build 
a kernel without those options, it fails to boot, complaining that 
dm-snapshot and others are missing.

Here is the sequence of events:
1.  Untar linux-2.6.17.tar.gz
	make menuconfig -- Yep, multi-device options are there.
2.  Apply patch-2.6.18-rc5
	make menuconfig -- Yep, again, multi-device options are there.
3.  Apply patch 2.6.18-rc5-mm1
	make menuconfig -- multi-device options are gone.

What am I doing wrong?

Thanks,
Jay

-- 
VGER BF report: H 0.360383
