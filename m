Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWAMQk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWAMQk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161559AbWAMQk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:40:59 -0500
Received: from main.gmane.org ([80.91.229.2]:52959 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161453AbWAMQk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:40:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Problem getting PCMCIA to compile in Kernel.
Date: Sat, 14 Jan 2006 01:40:28 +0900
Message-ID: <dq8l5t$fg0$1@sea.gmane.org>
References: <43C8252F.6483.C6B2A8@mikes.kuentos.guam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060103)
X-Accept-Language: en-us, en
In-Reply-To: <43C8252F.6483.C6B2A8@mikes.kuentos.guam.net>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael D. Setzer II wrote:
> I've tried to set the PCMCIA options to Y in the kernel build, but get a 
> message that something else is build as a modual, so these can not be 
> changed to y.

How did you do that?

Use `make menuconfig` to configure kernel.

> I went to the .config file and replaced every =m to =y, and then 
> ran make. The kernel then was built with no problem, but it reset all these 
> option back to =m.
> 
> CONFIG_PCMCIA_AHA152X=m
> CONFIG_PCMCIA_FDOMAIN=m
> CONFIG_PCMCIA_NINJA_SCSI=m
> CONFIG_PCMCIA_QLOGIC=m
> CONFIG_PCMCIA_SYM53C500=m
> CONFIG_I2C_STUB=m
> 
> I build kernels for G4L, and build everything directly into the kernel, but 
> these do not seem to work, and I don't have an ideal why, since everything 
> else is built in. So what am I missing. This is the 2.6.15 kernel. 

If you play with .config directly, run a `make oldconfig` after that.
So, `make oldconfig && make && make` should always work.
If you tired that ant it did NOT, please post your .config file (not
compressed) here, or upload it to a website (somewhere).

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

