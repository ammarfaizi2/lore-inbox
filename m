Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWBFTrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWBFTrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWBFTrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:47:19 -0500
Received: from kirby.webscope.com ([204.141.84.57]:50350 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932326AbWBFTrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:47:17 -0500
Message-ID: <43E7A7A2.3060909@linuxtv.org>
Date: Mon, 06 Feb 2006 14:46:42 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
Subject: Re: Linux drivers management
References: <1139250712.20009.20.camel@rousalka.dyndns.org> <200602061002.27477.joshua.kugler@uaf.edu> <Pine.LNX.4.61.0602061420400.17351@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602061420400.17351@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>Maybe it would be better for no drivers to be in the tree!
>Something along the lines of an automatic FTP site that
>interacts with a configuration program. You end up downloading
>the drivers that you need. In the case where you don't have
>an Internet connection, a distribution company would put the
>mirror on a CD or DVD.
>  
>
Regardless of whether or not the idea is practical, where would the 
funding come from?  Who is going to donate their time?  What if they get 
bored of it and nobody wants to pick up?

There are enough of us working for free on this stuff, and those that 
get paid already have enough on their plate.  What you're asking for is 
something that just isn't practical.

When I first read this, I thought you were joking... unfortunately, it 
looks like you are being serious.

>Right now, there are really too many drivers in the kernel.
>The kernel should have a stable API for drivers and they
>should be in a separate tree, either on the Web or on a
>distribution disc. There are many drivers that are as old
>as Linux! The 3c501.c and 3c503.c are examples. You can't
>remove them from the kernel without invoking a thousand
>angry responses. These boards and the ne*.c network boards
>just won't go away!
>  
>
Why would we WANT to remove them?  Linux is just about the only 
operating system that will run well on all old machines.  If we were to 
remove these drivers from the kernel, we might as well all throw our old 
hardware into the garbage.

>This means that the amount of drivers will continue to
>increase to, eventually, an unmanagable amount. This is
>why they really need to be seperately managed!
>  
>
That's part of what subsystems and subsystem maintainers are for.  Looks 
like somebody thought ahead. ;-)

FYI, v4l/dvb drivers can be built separately from the kernel as modules, 
directly from our mercurial repository, and we try to keep them all 
backwards compatable with older vanilla kernels.  Surely there are other 
subsystems that do something similar.

>****************************************************************
>The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
^^^ I'm sure you've been flamed about this already, so I won't say it....

Cheers,

Michael Krufky


