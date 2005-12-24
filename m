Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVLXVRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVLXVRW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVLXVRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:17:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37035 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750725AbVLXVRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:17:21 -0500
Date: Sat, 24 Dec 2005 22:16:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Wakko Warner <wakko@animx.eu.org>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Let non-root users eject their ipods?
In-Reply-To: <20051220035122.GA7233@animx.eu.org>
Message-ID: <Pine.LNX.4.61.0512242211030.29877@yvahk01.tjqt.qr>
References: <1135047119.8407.24.camel@leatherman> <20051220035122.GA7233@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> All,
>> 	I'm getting a little tired of my roommates not knowing how to safely
>> eject their usb-flash disks from my system and I'd personally like it if
>
>What exactly is ejecting flash media?

  (That's when the spring in the usb connector decides it had enough and 
  spits the ipod cable out. It is advised to wear a helmet to not get hurt 
  by the HV usb device, e.g. usb mass storage sticks. j/k)

Ejecting flash media is what `sdparm -C eject /dev/sdX` does. In case of 
cdroms, that's eject. In case of zip drives, I guess, it will be - see 
above - unloading zip disks via springs (now these things really eject 
hard), and in case of mass storage drives that can usually not be ejected 
(so-called "non-removable media", such as harddisks), it disconnects them. 
Another stage after umount, so to speak. (And BTW, you cannot run `sdparm 
-C load` on these usb media again; at least I cannot for my memory stick.)


Jan Engelhardt
-- 
