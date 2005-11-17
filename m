Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVKQXZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVKQXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVKQXZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:25:57 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:49680 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964874AbVKQXZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:25:56 -0500
Message-ID: <437D118A.3000306@rainbow-software.org>
Date: Fri, 18 Nov 2005 00:26:02 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Presario "reboot" problems
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> It appears as though Linux is still restarting as a "warm boot",
> rather than a cold boot (in other words, putting magic in the
> shutdown byte of CMOS) so the hardware doesn't get properly
> initialized. Would somebody please check this out. When changing
> operating systems, you need a cold-boot.
No, it does not. I know that my desktop PC reboots with a beep (and 
shows CPU information) from Linux - and it does not beep when rebooting 
from Windows 98.
Some BIOSes don't like when some devices are in some state. One example 
is my DTK FortisPro TOP-5A notebook - when rebooted from Linux, it hangs 
during POST - the fix was to add setpci <someting> to shutdown scripts 
to zero-out some cardbus controller registers.

-- 
Ondrej Zary
