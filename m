Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVHHPID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVHHPID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVHHPID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:08:03 -0400
Received: from news.cistron.nl ([62.216.30.38]:42723 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1750928AbVHHPIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:08:02 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Date: Mon, 8 Aug 2005 15:08:01 +0000 (UTC)
Organization: Cistron
Message-ID: <dd7sgh$ktg$2@news.cistron.nl>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
X-Trace: ncc1701.cistron.net 1123513681 21424 62.216.30.70 (8 Aug 2005 15:08:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  <torvalds@osdl.org> wrote:
>James and gang found the aic7xxx slowdown that happened after 2.6.12, and 
>we'd like to get particular testing that it's fixed, so if you have a 
>relevant machine, please do test this.


with me, rc6 lasted 18 hours:
reboot   system boot  2.6.13-rc6       Mon Aug  8 16:52          (00:11)
dth      pts/0        zaphod.dth.net   Sun Aug  7 22:14 - crash  (18:37)


scsi1:0:14:0: Attempting to abort cmd ffff810038f6dd40: 0x2a 0x0 0x3 0x91 0x45 0x10 0x0 0x0 0x1 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x13 Mode 0x11
Card was paused

For more info regarding kern.log etc:
http://newsgate.newsserver.nl/kernel/

2.6.12-mm1 survived 18+ days !

Can it be something with acpi that somehow loses an interrupt ?
This machine really does some heavy network/disktraffic.

Danny

