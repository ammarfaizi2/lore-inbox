Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVKYQdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVKYQdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 11:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVKYQdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 11:33:43 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:44947
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750819AbVKYQdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 11:33:42 -0500
Message-ID: <43873CD9.6070105@linuxwireless.org>
Date: Fri, 25 Nov 2005 10:33:29 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, James Ketrenos <jketreno@linux.intel.com>,
       yi.zhu@intel.com
Subject: Re: ipw2200 in 2.6.15-rc2-git4 warns about improper NETDEV_TX_BUSY
 retcode
References: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
In-Reply-To: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:

>Dell Latitude D610, FC4 base distro, kernel is:
>
>[asuardi@sandman ~]$ cat /proc/version
>Linux version 2.6.15-rc2-git4 (asuardi@sandman) (gcc version 4.0.1
>20050727 (Red Hat 4.0.1-5)) #2 Fri Nov 25 00:15:46 CET 2005
>
>Onboard wireless card as detected by kernel is:
>ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
>
> and I placed the 2.4 firmware from sourceforge.net in /lib/firmware.
>
>ifup eth1 yields this message:
>
>eth1: NETDEV_TX_BUSY returned; driver should report queue full via
>ieee_device->is_queue_full.
>  
>
There is bug 808 at bughost.org for the IPW2200 project.

I have asked the patch to be merged but I dunno why it hasn't been 
pushed up.

.Alejandro

>
>I'm connected to my wireless DSL router while typing this mail
> so it obviously isn't fatal...
>
>
>Thanks,
>
>--alessandro
>  
>

