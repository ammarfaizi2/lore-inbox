Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVISVlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVISVlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVISVlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:41:01 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:1193 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S932677AbVISVk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:40:59 -0400
Message-ID: <432F306B.40503@blueyonder.co.uk>
Date: Mon, 19 Sep 2005 22:40:59 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: later kernels vs ntpd
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2005 21:41:48.0335 (UTC) FILETIME=[F02553F0:01C5BD62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
 > Someone suggested that I needed the ipv6 stuff, so I built a 2.6.13.1
 > with all that turned on, but an overnight run of it also failed to
 > synch, so I'm back on 2.6.13-rc5, which works well.
 >
 > But this is preventing me from playing the coal mine canary. Does
 > anyone else have a suggestion?

Right up to 2.6.13-rc6-git12 I've used 
linux-2.6.13-rc6_timeofday-all.patch with no drift at all. With 
unpatched kernels (won't apply) up to 2.6.14-rc1-git5 on SuSE 9.3, I'm 
seeing -3 secs drift since reboot 1 hour ago, I think that's the max 
I've seen over several hours, I have a heat/hardware problem that causes 
a solid lockup at random times.
On the other box with the same hardware and Mandriva LE2005, no drift.
bumble:/root # ptktime&
[1] 27567
bumble:/root # localhost                       0 Mon Sep 19 22:35:58 2005
128.118.25.3                    0 Mon Sep 19 22:35:58 2005

bumble:/root # uptime
  22:36:15 up 22:35,  3 users,  load average: 0.00, 0.00, 0.00
bumble:/root # uname -r
2.6.14-rc1-git4

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
