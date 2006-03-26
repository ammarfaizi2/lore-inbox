Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWCZJnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWCZJnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWCZJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 04:43:14 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:36541 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750741AbWCZJnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 04:43:13 -0500
Message-ID: <4426620C.2040707@tlinx.org>
Date: Sun, 26 Mar 2006 01:42:36 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Security downgrade? CONFIG_HOTPLUG required in 2.6.16?
References: <44237D87.70300@tlinx.org> <20060325192635.GQ4053@stusta.de>
In-Reply-To: <20060325192635.GQ4053@stusta.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> - hotplugging devices != module loading
> - CONFIG_HOTPLUG does not load any code into the kernel.
> - hotplugging devices can work without any userspace support
>
> As an example, hotplugging an USB hard disk works fine with 
> CONFIG_MODULES=n and without any userspace support (assuming
> a static /dev).
>   
---
    Ah, I see.   But if I have no USB hard disk to plug in?
Should I still be compiling in HOTPLUG?  Seems a waste.
Thanks for the example though...

-linda
