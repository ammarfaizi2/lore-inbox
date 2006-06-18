Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWFRMDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWFRMDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWFRMDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:03:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:62629 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932182AbWFRMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:03:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44954102.3090901@s5r6.in-berlin.de>
Date: Sun, 18 Jun 2006 14:03:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: [git pull] ieee1394 tree for 2.6.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.736) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

the IEEE 1394 subsystem updates for Linux 2.6.18 are now staged in Ben's 
revived linux1394 git tree. I guess the URL to pull from is
git://git.kernel.org/pub/scm/linux/kernel/git/bcollins/linux1394-2.6.git

The updates in there are basically identical to the ieee1394 subsystem 
patches in 2.6.17-rc6-mm2. The essence:
  - a few fixes which did not seem important enough for 2.6.17
  - a performance tweak in the DMA routines
  - enhanced hardware compatibility (with 1394b PHYs when running at
    S100...S400, and with devices with link speed < phy speed)
  - minor coding updates, e.g. partial sem2mutex and kthread conversion

Thanks,
-- 
Stefan Richter
-=====-=-==- -==- =--=-
http://arcgraph.de/sr/
