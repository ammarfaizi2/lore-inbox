Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbUBXOLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUBXOLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:11:31 -0500
Received: from ns.adis.at ([195.64.0.34]:39686 "EHLO ns.adis.at")
	by vger.kernel.org with ESMTP id S262252AbUBXOKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:10:17 -0500
Message-ID: <403B5B47.2030907@petermair.at>
Date: Tue, 24 Feb 2004 15:10:15 +0100
From: Patrick Petermair <kernel-ml@petermair.at>
Reply-To: kernel-ml@petermair.at
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adaptec 1210SA SATA Controller Performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yesterday I've setup a server with Adaptec's 1210SA SATA Controller and 
2 SATA disks. According to the kernel changelog the controller is 
supported since 2.6.2

I've installed Debian on an IDE disk, built a 2.6.3 kernel with 
CONFIG_SCSI_SATA_SIL, rebooted and the kernel detected the controller 
plus both SATA disks (sda, sdb). As the next step I wanted to create a 
software raid 1 with the 2 SATA disks. Because it took mdadm forever to 
finish, I checked /proc/mdstat and saw a progress bar with a rate of 12MB/s!

Even my oldest IDE disk is faster than this. Is there a way to tweak the 
SATA controller/disk with some kernel-options or is the driver not 
providing more speed?

Any hints?
Thanks..
Patrick
