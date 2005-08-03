Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVHCIiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVHCIiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 04:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVHCIhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 04:37:32 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:62401 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262143AbVHCIha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 04:37:30 -0400
Message-ID: <42F08247.1020405@anagramm.de>
Date: Wed, 03 Aug 2005 10:37:27 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bgerard <bgerard@axalto.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hotplug problem
References: <42F078F3.4040808@axalto.com>
In-Reply-To: <42F078F3.4040808@axalto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben!

bgerard wrote:
> I'm working on an embeded system with linux kernel 2.4.27 and busybox 
> 1.00. Lately I've decided to add hotplug feature to my kernel in order 
> to automaticaly mount usb keys.
> 
> When I plug the usb key, I can see in the kernel debug that 
> "/sbin/hotplug" is called but my script is not executed. I've tried to 
> replace the hotplug script by a simple one but nothing appeared. Here is 
> my script :
> #!/bin/sh
> echo "usb key un/plugged"

I don't know much about hotplugging on 2.4.x and how you might need
to enable it in /proc... it just works for me on 2.6. with
CONFIG_HOTPLUG enabled and the latest hotplug-scripts.

> The script is working when I run it myself (./sbin/hotplug )
> 
> I've also noticed that when kmod try to call modprobe, it's not executed 
> while the debug message says that everything went fine.

Try newer modutils?

And you might have more luck asking on:
linux-hotplug-devel@lists.sourceforge.net

Greets,

Clemens

