Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280755AbRKOQN0>; Thu, 15 Nov 2001 11:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280930AbRKOQNR>; Thu, 15 Nov 2001 11:13:17 -0500
Received: from mustard.heime.net ([194.234.65.222]:29850 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280755AbRKOQNL>; Thu, 15 Nov 2001 11:13:11 -0500
Date: Thu, 15 Nov 2001 17:13:09 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Linux i/o tweaking
Message-ID: <Pine.LNX.4.30.0111151535060.13411-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

After three days at Compaq's lab in Oslo, testing their medium-level
servers and storage systems with Linux, I've come to some sort of
conclusions, although these may be wrong. I also have come over a few
problems that I couln't find a good solution to.

 * When running RAID from a Compaq Smart 5302/64 controller, software
RAID-5 is (slightly - ~15%) faster (on JBOD - each disk is configured as
a RAID-0 device with max - 256kB - stripe size) than the
hardware/controller based RAID-5. Both CPUs (1266MHz/512kB cache) are
maxed out by reading from software RAID-5 (???), giving me >= 107MB/s on
two SCSI-3 buses with six disks on each bus.

 * Even though I can get up to 25 MB/s from each disk, I can't get more
than 107 MB/s on the whole bunch (12 drives). It doesn't help much to do
RAID-0 either. Don't understand anything ...

Thanks for all help.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.



