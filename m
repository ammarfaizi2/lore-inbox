Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVIVKtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVIVKtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVIVKtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:49:16 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:15544 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030252AbVIVKtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:49:15 -0400
Message-ID: <43328C2B.8060302@comcast.net>
Date: Thu, 22 Sep 2005 06:49:15 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ipw2200 Broken 2.6.13: "firmware_loading_store: unexpected value
 (0)"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.6.13-mm1, and i tried both 1.0.6 and the included driver 
(both matched with the appropriate ieee80211 driver) and I'm using 
debian unstable's version of hotplug Version: 0.0.20031013-2.   I have 
very little installed on this computer as it's a WRAP board with mini 
pci intel 2915.  Is anything in userspace required to load firmware 
besides hotplug? I dont use udev or devfs ...not sure if there are /dev 
entries or what. 

I'm getting this error constantly (thousands of times a second when 
modprobing the ipw2200 driver (any version)
 
firmware_loading_store: unexpected value (0)


I have the firmware available in every possible accepted location for 
firmware.   I have no doubt that it's finding the firmware, but unable 
to load it.  My sysfs driver directory for the pci device has no "data" 
file/directory in it, which I thought is where firmware is loaded. 

If any other info is required to figure this problem out.  Just mention 
it.  I'll provide everything.  Attached is my config for the kernel in 
question. 

