Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSBRX5D>; Mon, 18 Feb 2002 18:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289009AbSBRX4y>; Mon, 18 Feb 2002 18:56:54 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:58753 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S289007AbSBRX4j>;
	Mon, 18 Feb 2002 18:56:39 -0500
Message-ID: <3C7194AD.2050805@tmsusa.com>
Date: Mon, 18 Feb 2002 15:56:29 -0800
From: J Sloan <joe@tmsusa.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <3C717DEA.7090309@candelatech.com> <E16cwUx-00073d-00@the-village.bc.nu> <20020219002614.A27210@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW our servers that wrapped around
almost 4 months ago have been running
fine, no real problems - Red Hat 6.1 with
2.2.17-pre4 kernel.

Joe

bert hubert wrote:

>On Mon, Feb 18, 2002 at 10:31:34PM +0000, Alan Cox wrote:
>
>>>I wonder, is it more expensive to write all drivers to handle the
>>>wraps than to take the long long increment hit?  The increment is
>>>
>>Total cost of handling it right - 0 clocks. Its simply about maths order
>>and sign 
>>
>
>$ uname -a ; uptime
>Linux newyork-1 2.2.18 #3 Mon Dec 11 15:57:33 EST 2000 i686 unknown
>  6:22pm  up 425 days,  1:35,  3 users,  load average: 0.10, 0.05, 0.01
>
>This server is pretty remote and hard to reach, and not sure to reboot
>properly unattended - are there predictions about how well 2.2.18 will
>survive jiffy wraparound?
>
>Would you consider it worth rebooting for? By the way, this is our second
>most important production server, I'm exceedingly pleased with the
>stability. We've abused it no end.
>
>Thanks.
>
>Regards,
>
>bert
>


