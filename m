Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVFKU32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVFKU32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVFKU31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:29:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61920 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261824AbVFKU1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:27:31 -0400
Date: Sat, 11 Jun 2005 22:27:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VmallocTotal meminfo
Message-ID: <Pine.LNX.4.61.0506112225330.2372@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


/proc/meminfo:
MemTotal:       256656 kB
MemFree:         32480 kB
...
LowTotal:       256656 kB
LowFree:         32480 kB
SwapTotal:      530136 kB
SwapFree:       530136 kB
...
VmallocTotal:   778164 kB
VmallocUsed:     22468 kB
VmallocChunk:   755404 kB

What's the VmallocTotal telling me? How is it calculated?
I ask because running a surprisingly modern Linux on a surprisingly ancient 
machine results in VmallocTotal being somewhere in the 1-gigabyte range, which 
can _never_ ever be.



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
