Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277554AbRJETYl>; Fri, 5 Oct 2001 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277558AbRJETYb>; Fri, 5 Oct 2001 15:24:31 -0400
Received: from august.V-LO.krakow.pl ([62.121.131.17]:25100 "EHLO
	august.V-LO.krakow.pl") by vger.kernel.org with ESMTP
	id <S277554AbRJETYP>; Fri, 5 Oct 2001 15:24:15 -0400
Date: Fri, 5 Oct 2001 21:24:43 +0200 (CEST)
From: "[solid]" <solid@V-LO.krakow.pl>
To: <linux-kernel@vger.kernel.org>
Subject: bug(?) with software raid on 2.4.10
Message-ID: <Pine.LNX.4.33.0110052115420.9326-100000@august.V-LO.krakow.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greetings

i have got slackware 8.0 with the newest raidtools (from
ftp.kernel.org) and 2.4.10 compiled with all raid options ON. i have
created on two hard disks two partitions (hda3 & hdc2), the first one
about 4GB the second 1.GB. i made the type fd(linux raid autodetect)
and set up a raid-0 array using mkswap. everything went fine- i could
'use and abuse' the md0 as was written in the HOWTO, so i created a
reiserfs partition(newest reieserfsprogs) and mounted it. to test the
speed, i decided to unpack something big- linux-2.4.8.tar.gz. after
some time(somewhere in the drivers/block dir i think...) it suddenly
stopped. i've tapped eneter a few times- ok, there was a response. but
nothing happened, and after few secs the framebuffer cursor
disappeared and the achien stopped responding completely. thinking it
was some kind of conflict between reiser and raid, i've tryed the same
procedure witch ext2, and encountered the same lack of responce. also,
trying to install slackware 8 from CD, during the glibc installation,
the same happened(if someone doesn't know- slackware uses a simple
.tgz package format).
anybody has maybe encountered this? somefix/workaround?

[solid]
Registered Linux user number 212159

