Return-Path: <linux-kernel-owner+w=401wt.eu-S932209AbXAIVLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbXAIVLp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAIVLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:11:45 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:54799 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbXAIVLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:11:44 -0500
Message-ID: <45A3FF32.1030905@wolfmountaingroup.com>
Date: Tue, 09 Jan 2007 13:46:42 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just finished pulling out a melted IDE flash drive out of a Shuttle 
motherboard with the intel 945 chipset which claims to support
SATA and IDE drives concurrently under Linux 2.6.18.

The chip worked for about 30 seconds before liquifying in the chassis.  
I note that the 945 chipset in the shuttle PC had some serious
issues recognizing 2 x SATA devices and a IDE device concurrently.   Are 
there known problems with the Linux drivers
with these newer chipsets.

One other disturbing issue was the IDE flash drive was configured (and 
recognized) as /dev/hda during bootup, but when
it got to the root mountint, even with root=/dev/hda set, it still kept 
thinking the drive was at scsi (ATA) device (08,13)
and kept crashing with VFS cannot find root FS errors.

Jeff
