Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbTCYRiu>; Tue, 25 Mar 2003 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbTCYRit>; Tue, 25 Mar 2003 12:38:49 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:43394 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S263151AbTCYRiM>;
	Tue, 25 Mar 2003 12:38:12 -0500
Message-ID: <3E8096A4.3010009@portrix.net>
Date: Tue, 25 Mar 2003 18:49:24 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with rivafb again
References: <Pine.LNX.4.44.0303251723480.3789-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0303251723480.3789-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
>>I'm getting plenty of those when switch from X (nv driver) to console 
>>(rivafb) since your latest code got merged in bk. Also, the console 
>>screen is really corrupted when switching back from X (sort of worked 
>>before) and the little penguin isn't drawn anymore at bootup time.
> 
> 
> Do you have "UseFBdev" in your XF96Config file? You need to enable that 
> otherwise X and fbdev will conflict when setting the hardware. As for the 
> little penguin you need need to enable the Logo code in the video menu. 
> The logo code is also used by the SGI Newport driver.
> 
> 
I've no such settings in my XF86Config. But it used to work before 
without it - I'll try.
And as you may have seen from my .config options, the logo code _is_ 
enabled or did I overlook something?

Jan

# Logo configuration
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

