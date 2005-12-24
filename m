Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVLXVSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVLXVSA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVLXVSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:18:00 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14285 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750726AbVLXVR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:17:59 -0500
Date: Sat, 24 Dec 2005 22:17:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com, axboe@suse.de
Subject: Re: [RFC] Let non-root users eject their ipods?
In-Reply-To: <1135248999.10383.29.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0512242217170.29877@yvahk01.tjqt.qr>
References: <1135047119.8407.24.camel@leatherman> <1135248999.10383.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So below is a patch that allows non-root users to eject their ipods. (It
>> seems it should be safe_for_write() but eject opens the device for
>> RDONLY, so eject may be wrong here as well). 
>> 
>> Comments, flames?
>
>I think its probably uninteresting to the majority of users to solve it
>that way (not that its wrong that I can see). The desktops handle
>automount/umount these days [...]

Don't forget about the folks that don't run udev. :D



Jan Engelhardt
-- 
