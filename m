Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTJNLxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJNLxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:53:49 -0400
Received: from sea2-f47.sea2.hotmail.com ([207.68.165.47]:53508 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262420AbTJNLxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:53:47 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: hotplug and /etc/init.d/hotplug
Date: Tue, 14 Oct 2003 13:53:46 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F47xegIqunLOyD000050c7@hotmail.com>
X-OriginalArrivalTime: 14 Oct 2003 11:53:46.0575 (UTC) FILETIME=[D2F07DF0:01C39249]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am running RedHat 9 with 2.4.20-8  kernel ;
Now , I have a questo about hotplug:
I have hotplug-2002_04_01-17 installed (rpm);

Now , I read the readme of this rpm ;
in their "installing"  section , clause 5 , it says:
# cp etc/rc.d/init.d/hotplug /etc/rc.d/init.d/hotplug
# cd /etc/rc.d/init.d
# chkconfig --add hotplug

I checked on my machine and there is no "hotplug" file in that folder.
Nevertheless, hotplugin works (because when I plug a USB camera
I can see in the kernel log (/var/log/messages)  messages which start with
/etc/hotplug/usb.agent

I also looked at the kernel code (method "call_polcy" in usb.c )
and it doesn't seems to me that the hotplug in /etc/init.d is needed .

can anybody make some clarifications ?
sting

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail

