Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTITNUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTITNUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:20:32 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:25445
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261875AbTITNUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:20:31 -0400
Message-ID: <3F6C543D.7080706@rogers.com>
Date: Sat, 20 Sep 2003 09:21:01 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030902 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm3 VFAT File system problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.102.238.105] using ID <dw2price@rogers.com> at Sat, 20 Sep 2003 09:20:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon moving from -mm2 to -mm3, my vfat filesystems did not automatically 
bount at bootup as per the fstab and could not be accessed by 
applications in Gnome ie. my mount point showed no subdirectories or files.

I could manually mount (not by mount /mnt/win_c but by the full mount -t 
vfat /dev/hda1 /mnt/win_c) and I could explore using ls in terminals but 
programs in Gnome could not open the filesystem.

Upon rebooting into -mm2 everything was fine again.

