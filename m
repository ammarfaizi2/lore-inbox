Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbRGDOHY>; Wed, 4 Jul 2001 10:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbRGDOHO>; Wed, 4 Jul 2001 10:07:14 -0400
Received: from prograine2.raster.krakow.pl ([212.160.153.165]:61112 "EHLO
	procomnet2.prograine.net") by vger.kernel.org with ESMTP
	id <S265003AbRGDOHC>; Wed, 4 Jul 2001 10:07:02 -0400
Date: Wed, 4 Jul 2001 16:11:54 +0200 (CEST)
From: <pt@procomnet2.prograine.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Intel SRCU3-1 RAID (I2O) and 2.4.5-ac18
Message-ID: <Pine.LNX.4.33.0107041550300.23057-100000@procomnet2.prograine.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> modprobe i2o_config

> may be needed

Yes of course, why didn't I think about it...

Anyway, the cgi tool doesn't seem to identify any problems with
the controller before the freeze. Then it freezes together with
the copying process. And after reboot I see errors in the
controller's log - they are all exactly same:

Function: Media Unlock
Error Code: Access Violation
User Info: 00000000
Disk Serial No is not set, just no data in the table field
Timestamps are somewhat strange - three erroror logs one after
another then about 3-4 minutes delay and again three messages

The RAID volume sometimes enters a state after reboot where all
three disks are working and the cgi says the volume is
initializing.



Przemek Tomala


