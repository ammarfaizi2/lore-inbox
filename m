Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265307AbUEOCKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265307AbUEOCKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 22:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUEOCKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 22:10:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34032 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265368AbUEOCJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 22:09:03 -0400
Message-ID: <40A57BB6.30503@mvista.com>
Date: Fri, 14 May 2004 19:08:54 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com> <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net> <4097FED8.3020003@mvista.com> <Pine.LNX.4.50.0405042110440.30304-100000@monsoon.he.net> <40999017.4090603@mvista.com> <20040514025053.GA14773@elf.ucw.cz>
In-Reply-To: <20040514025053.GA14773@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hey, I want linux smartphone ;-).

Me too ;)

> In case of that dual-core CPU, does linux really run on both CPUs? Do
> we get sources for GSM network stack, too?

As Nicolas mentioned, the voiceband/RF stuff is probably on the DSP in 
such systems and typically runs in a custom environment, perhaps with 
libraries supplied by the silicon vendor.  I am not myself familiar with 
a Linux-based phone software offering that includes open source GSM 
modem drivers or GSM/GPRS network stacks and such.

> Is there some preliminary docs about such beasts available somewhere?

Nicolas mentioned sites for the popular TI OMAP platform (ARM925/6T), 
another is Renesas SH-Mobile.  I'm not aware of writeups regarding Linux 
support for CPU+DSP designs, if that's of interest; in my capacity I 
mostly treat the DSP as an unmanaged black box device.  But in the 
context of power management there are a few unavoidable interactions, 
for example, phone software developers get cranky when Linux decides to 
power down some or all of the system while the DSP was busy doing 
something important and there's a common clock or power domain.


Todd

