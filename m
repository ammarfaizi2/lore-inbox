Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267214AbTAAKLp>; Wed, 1 Jan 2003 05:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTAAKLp>; Wed, 1 Jan 2003 05:11:45 -0500
Received: from mail.mediaways.net ([193.189.224.113]:30276 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S267214AbTAAKLo>; Wed, 1 Jan 2003 05:11:44 -0500
Subject: 2.4.21-pre2 harddisk not in /proc/partitions with pdc_new
From: Soeren Sonnenburg <kernel@nn7.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041416324.982.11.camel@sun>
Mime-Version: 1.0
Date: 01 Jan 2003 11:18:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As of 2.4.21-pre harddisks that I attach to a secondary PDC20268 don't
show up (although correctly detected) in /proc/partitions. Instead the
/dev/hda's partition table is cloned ...

As this box has two pdc20268 (promise tx2) ide controllers I can
reproduce this behaviour on both of them with different harddisks.

Linux was booting using a harddisk on the onboard via vt8235 chipset
(asus a7v8x).

This problem does not occur with 2.4.20. 

I will happily supply additional information if needed.

Thanks,
Soeren.

