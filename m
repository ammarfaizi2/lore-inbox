Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVAXNmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVAXNmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVAXNmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:42:08 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:43942 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261361AbVAXNmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:42:04 -0500
Message-ID: <41F4FB1D.4090302@ens-lyon.fr>
Date: Mon, 24 Jan 2005 14:41:49 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F4E28A.3090305@ens-lyon.fr>
In-Reply-To: <41F4E28A.3090305@ens-lyon.fr>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin a écrit :
> Andrew Morton a écrit :
> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/ 
>>
>>
>>
>> - Lots of updates and fixes all over the place.
> 
> 
> Hi Andrew,
> 
> X does not work anymore when using DRI on my Compaq Evo N600c (Radeon 
> Mobility M6 LY).
> My XFree 4.3 (from Debian testing) with DRI uses drm and radeon kernel 
> modules.
> 
> Instead of the usual gdm window, I get a black or noisy screen 
> (remaining image parts of
> last working session). The mouse pointer works. Sysrq works. But 
> Caps-lock doesn't work.
> The machine pings but I can't ssh.
> 
> I don't know exactly what's happening. I don't see anything interesting 
> in dmesg.

Thanks to Benoit who found this at the end of dmesg:
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Couldn't find an AGP VGA controller.

while Linus' 2.6.11-rc2 says:
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

Regards,
Brice
