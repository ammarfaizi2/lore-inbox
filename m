Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274131AbRI0Xhp>; Thu, 27 Sep 2001 19:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274151AbRI0Xhf>; Thu, 27 Sep 2001 19:37:35 -0400
Received: from femail39.sdc1.sfba.home.com ([24.254.60.33]:46327 "EHLO
	femail39.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274131AbRI0XhZ>; Thu, 27 Sep 2001 19:37:25 -0400
Date: Thu, 27 Sep 2001 16:37:04 -0700
From: Daiki Matsuda <dyky@df-usa.com>
To: linux-kernel@vger.kernel.org
Cc: dyky@df-usa.com
Subject: continue infinitely /proc/partition
Message-Id: <20010927163704.59a90658.dyky@df-usa.com>
Organization: Digital Factory USA
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.
>From long ago, I have a problem for /proc/partition. Its problem is that
after connecting USB CF Reader, I read /proc/partition with the command
'cat /proc/partition', the infinite result is shown. And any programs
using /proc/partition does not end but run infinitely. I confirmed the bug
from kernel-2.4.4.
In similar, at Alpha Architecture System (XP1000), I am using two SCSI
cards that they are using different driver qlogicisp (onboard) and aic7xxx
(PCI). Till 2.4.10-pre11 I can use both, but after it not. Or, in boot
time aic7xxx driver is not read, system is boot. But after loading
aic7xxx, /proc/partition is infinite.

Best Regards
MATSUDA, Daiki
