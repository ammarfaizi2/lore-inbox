Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWDEHxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWDEHxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWDEHxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:53:00 -0400
Received: from [84.204.75.166] ([84.204.75.166]:701 "EHLO shelob.oktetlabs.ru")
	by vger.kernel.org with ESMTP id S1751062AbWDEHw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:52:59 -0400
Message-ID: <44337759.4040507@yandex.ru>
Date: Wed, 05 Apr 2006 11:52:57 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device model and character devices
References: <44322A6F.4000402@yandex.ru> <20060404164823.GA31398@kroah.com>
In-Reply-To: <20060404164823.GA31398@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Because "struct device" generally is not related to a major:minor pair
> at all.  That is what a struct class_device is for.  Lots of struct
> device users have nothing to do with a char device, and some have
> multiple char devices associated with a single struct device.
Well, OK, but AFAIK, your long-term plan is to merge class_device and 
device, so in the long-term perspective it does not matter. And those 
who do not need a character device support may have a possibility to 
disable it.

> All that being said, yes, there is a disconnect between the driver model
> parts and the char subsystem.  It's been something that I've wanted to
> fix for a number of years, but never had the time to do so.  If you want
> to work toward doing this, I'd be glad to review any patches.
Will see. At this point my knowledge and understanding is not so deep, 
so I don't think I'm able to provide decent patches. May be in future. 
For now I'm only wondering.

Thanks.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
