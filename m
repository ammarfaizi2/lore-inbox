Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVIJCL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVIJCL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVIJCL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:11:57 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:33461 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030530AbVIJCL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:11:56 -0400
Message-ID: <432240E9.9010400@eyal.emu.id.au>
Date: Sat, 10 Sep 2005 12:11:53 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: RAID resync speed
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that my 3-disk RAID was syncing at about 40MB/s, now that I
added a fourth disk it goes at only 20+MB/s. This is on an idle machine.

Individually, each disk measures 60+MB/s with hdparm.

kernel: 2.6.13 on ia32
Controller: Promise SATAII150 TX4
Disks: WD 320GB SATA

Q: Is this the way the raid code works? The way the disk-io is managed? Or
could it be due to the SATA controller?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
