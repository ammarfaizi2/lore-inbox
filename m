Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVHASiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVHASiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVHASiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:38:12 -0400
Received: from [195.144.244.147] ([195.144.244.147]:48264 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S261170AbVHASiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:38:05 -0400
Message-ID: <42EE6C09.3060609@varma-el.com>
Date: Mon, 01 Aug 2005 22:38:01 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Jamey Hicks <jamey.hicks@hp.com>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Where is place of arch independed companion chips?
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com> <20050801181357.GA31144@suse.de>
In-Reply-To: <20050801181357.GA31144@suse.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> On Mon, Aug 01, 2005 at 08:29:35AM -0400, Jamey Hicks wrote:
> 
>>Andrey Volkov wrote:
>>
>>
>>>Hi Greg,
>>>
>>>While I write driver for SM501 CC (which have graphics controller, USB
>>>MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
>>>I bumped with next ambiguity:
>>>Where is a place of this chip's Kconfig/drivers in
>>>kernel config/drivers tree? May be create new node in drivers subtree?
>>>Or put it under graphics node (since it's main function of this CC)?
>>>
>>>AFAIK, this is not one such multifunctional monster in the world, so
>>>somebody bumped with this problem again in future.
>>>
>>>
>>>
>>
>>Good question.  I was about to submit a patch that created 
>>drivers/platform because the toplevel driver for MQ11xx is a 
>>platform_device driver.  Any thoughts on this?
> 
> 
> drivers/platform sounds good to me.

May be better drivers/chipset?
Because "platform" imply only platform_device drivers,
but, SM501 as ex., could be connected through PCI too.

-- 
Regards
Andrey Volkov
