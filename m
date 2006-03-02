Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWCBVOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWCBVOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWCBVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:14:32 -0500
Received: from mail.linicks.net ([217.204.244.146]:29378 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932307AbWCBVOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:14:31 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [question] memory usage
Date: Thu, 2 Mar 2006 21:14:24 +0000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603022114.24712.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can anybody explain this to me please.

I have 1.5GB RAM - dmesg (boot -> append="mem=1536M"):

639MB HIGHMEM available.
896MB LOWMEM available.

I have 2GB swap:

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1         244     1959898+  82  Linux swap

I have no issues on this - works GREAT.  Normally, after a reboot, and over 
night after logrotate/updatedb etc. run, I end up with about 200MB free RAM 
that is used/reclaimed.  very rarely do I hit disk swap at all (building KDE 
usually grabs about 100Kb, but that is infrequent).

Last week I bought my first DVD player (yes, I know, I am late to the party!).  
When I watch a DVD (Xine), memory usage hardly goes up (no swap ever used).  
But after finishing, I then see memory usage is way down:


nick@linuxamd:nick$ uptime; free
 21:11:26 up 1 day,  4:57,  1 user,  load average: 0.06, 0.10, 0.26
             total       used       free     shared    buffers     cached
Mem:       1556216     411144    1145072          0      28408     236704
-/+ buffers/cache:     146032    1410184
Swap:      1959888          0    1959888


Why is this?

Thanks,

Nick

-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
