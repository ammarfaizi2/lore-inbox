Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUCDO5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCDO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:57:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31209 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261920AbUCDO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:57:44 -0500
Date: Thu, 4 Mar 2004 15:38:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bob Dobbs <bob_dobbs@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mobile Intel Pentium(R) 4 - M CPU 2.60GHz - kernel 2.6.3
Message-ID: <20040304143822.GD531@openzaurus.ucw.cz>
References: <20040227004631.31D663982E7@ws5-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227004631.31D663982E7@ws5-1.us4.outblaze.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What happens is during heavy loads my cpu drops from 2.60GHz down to 1.20GHz, this happens for a few minutes, say 5 - 10 

Overheat?

> I even tried to echo the options at bootup:
> 
> echo 2600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq &
> echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq &
> 
> I tried to make those files set at: 2.00GHz min and 2.60GHz max, but something changes them right back to 1.20GHZ no matter what I do.
> 

What about forcing it at 1GHz during boot, instead?

> Is there a patch or anything to force the cpu to run at 2.60GHz all the time?
> 


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

