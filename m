Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKINcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKINcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVKINcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:32:14 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:38795 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750748AbVKINcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:32:13 -0500
Message-ID: <4371FA5B.6030900@bootc.net>
Date: Wed, 09 Nov 2005 13:32:11 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14-mm1 RAID-1 in D< state
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I haven't noticed this until today...but my load average has been 
skyrocketing past 3.00 since Monday, which is when I upgraded to 
2.6.14-mm1. I've got 3 Software RAID-1 arrays across 4 SATA disks, and 
all 3 processes are locked in an uninterruptible sleep.

What's interesting, though, is I haven't noticed a degradation of 
performance at all, and all the arrays work absolutely fine. They aren't 
rebuilding or doing anything strange that I can see.

Any ideas?

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
