Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbUJ0QQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbUJ0QQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUJ0QQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:16:29 -0400
Received: from [195.23.16.24] ([195.23.16.24]:52623 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262494AbUJ0QOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:14:41 -0400
Message-ID: <417FC96B.8030402@grupopie.com>
Date: Wed, 27 Oct 2004 17:14:35 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>	 <417FB7BA.9050005@grupopie.com> <1098892587.8313.5.camel@krustophenia.net>
In-Reply-To: <1098892587.8313.5.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.11; VDF: 6.28.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2004-10-27 at 15:59 +0100, Paulo Marques wrote:
> 
>>I am one of the members of the robotic soccer team from the University 
>>of Oporto, and a couple of months ago we were looking for new 
>>motherboards for our robots, because we are starting to need new 
>>hardware (on-board lan, usb2.0, etc.).
>>
>>We really don't need excepcional performance, but we really, really need 
>>low power consumption, so lowering the clock on a standard mainboard 
>>seemed to be the best cost/performance scenario.
>>
>>Could this driver be used to keep a standard p4 processor at say 25% 
>>clock speed at all times?
>>
> 
> 
> Why don't you try the VIA EPIA mini-ITX boards?  These are designed for
> low power applications like yours.  I am running the M-6000 which has a
> fanless 600Mhz C3 processor, the newer fanless models run at 1Ghz.  And,
> on top of that they support speed scaling so you can slow it down even
> more.

Yes, we tried those, but floating point calculations completely kill the 
performance on those boards.

Even at 25% speed a P4 2.8GHz gives a 700MHz clock which completely 
toasts a 600MHz (or even a 1GHz) C3 in floating point calculations... :(

Even more, I can get a Asus mainboard with integrated VGA, LAN, USB, 
Audio, for half the price of a VIA EPIA mini-ITX with comparable integer 
performance. As we always have to buy these things in quantities of 5, 
this can make some difference.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
