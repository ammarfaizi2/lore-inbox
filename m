Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVLBWLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVLBWLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLBWLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:11:24 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:202 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750732AbVLBWLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:11:23 -0500
Message-ID: <4390C683.2030507@candelatech.com>
Date: Fri, 02 Dec 2005 14:11:15 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Keyboard broken in 2.6.13.2
References: <43909451.20105@candelatech.com> <200512021615.16247.dtor_core@ameritech.net>
In-Reply-To: <200512021615.16247.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Friday 02 December 2005 13:37, Ben Greear wrote:
> 
>>I have a system with a super-micro P8SCI motherboard.
>>
>>The default FC2 kernel (2.6.10-1.771_FC2smp) works fine, but
>>when I try to boot a 2.6.13.2 kernel, I see this error:
>>
>>i8042.c: Can't read CTR while initializing i8042
>>
>>If I hit the keyboard early in the boot, the system will just reboot.
>>
>>If I wait a bit, then it will boot to a prompt, but no keyboard input
>>is accepted.
>>
> 
> 
> Does booting with "usb-handoff" boot option help any? 

Not sure, but acpi=no works.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

